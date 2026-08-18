# Validate-FormLibrary.ps1
# Validates the aviation-form-library integrity:
#   - every form JSON parses
#   - every schema JSON parses
#   - form-registry codes match form files (both directions)
#   - every form has required top-level keys
#   - every field has name/type/required
#   - uiMetadata sections and validationRules reference existing fields
#
# Usage: powershell -ExecutionPolicy Bypass -File .\tools\Validate-FormLibrary.ps1

$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot | Split-Path -Parent
$formsDir = Join-Path $root 'forms'
$schemasDir = Join-Path $root 'schemas'
$registryPath = Join-Path $root 'config\form-registry.json'

$failures = @()
$warnings = @()

Write-Host "=== Aviation Form Library Validation ===" -ForegroundColor Cyan

# 1. Validate every form JSON parses
Write-Host "[1/5] Parsing form definitions..."
$formFiles = Get-ChildItem -Path $formsDir -Filter '*.json'
$forms = @{}
foreach ($f in $formFiles) {
    try {
        $form = Get-Content -Raw -LiteralPath $f.FullName | ConvertFrom-Json
        $forms[$f.BaseName] = $form
        Write-Host "  OK  $($f.Name)" -ForegroundColor Green
    } catch {
        $failures += "INVALID JSON: $($f.Name) - $($_.Exception.Message)"
        Write-Host "  FAIL $($f.Name)" -ForegroundColor Red
    }
}

# 2. Validate schemas parse
Write-Host "[2/5] Parsing schemas..."
$schemaFiles = Get-ChildItem -Path $schemasDir -Filter '*.json'
foreach ($f in $schemaFiles) {
    try {
        Get-Content -Raw -LiteralPath $f.FullName | ConvertFrom-Json | Out-Null
        Write-Host "  OK  $($f.Name)" -ForegroundColor Green
    } catch {
        $failures += "INVALID SCHEMA: $($f.Name) - $($_.Exception.Message)"
        Write-Host "  FAIL $($f.Name)" -ForegroundColor Red
    }
}

# 3. Registry consistency
Write-Host "[3/5] Registry consistency..."
$registry = Get-Content -Raw -LiteralPath $registryPath | ConvertFrom-Json
$registryCodes = @($registry.forms | ForEach-Object { $_.code })
$fileCodes = @($formFiles | ForEach-Object { ($_.BaseName -split '_')[0] })

foreach ($code in $registryCodes) {
    if ($code -notin $fileCodes) {
        $failures += "REGISTRY-ONLY: registry code $code has no form file"
        Write-Host "  FAIL registry-only: $code" -ForegroundColor Red
    }
}
foreach ($code in $fileCodes) {
    if ($code -notin $registryCodes) {
        $failures += "ORPHAN FILE: form file $code has no registry entry"
        Write-Host "  FAIL orphan file: $code" -ForegroundColor Red
    }
}

$dupCodes = $registryCodes | Group-Object | Where-Object { $_.Count -gt 1 } | ForEach-Object { $_.Name }
foreach ($d in $dupCodes) {
    $failures += "DUPLICATE CODE: $d appears more than once in registry"
    Write-Host "  FAIL duplicate code: $d" -ForegroundColor Red
}
if (-not $dupCodes) { Write-Host "  OK  1:1 registry/file match" -ForegroundColor Green }

# 4. Required keys + required field attributes + duplicate fields
Write-Host "[4/5] Form structure checks..."
$requiredKeys = @('formCode', 'name', 'version', 'category', 'status', 'sourceStatus', 'fields', 'workflow')
foreach ($name in $forms.Keys) {
    $form = $forms[$name]
    foreach ($key in $requiredKeys) {
        if (-not ($form.PSObject.Properties.Name -contains $key)) {
            $failures += "${name}: missing top-level key '$key'"
            Write-Host "  FAIL $name missing key $key" -ForegroundColor Red
        }
    }
    $seen = @{}
    foreach ($field in $form.fields) {
        foreach ($attr in @('name', 'type', 'required')) {
            if (-not ($field.PSObject.Properties.Name -contains $attr)) {
                $failures += "${name}: field missing attribute '$attr'"
                Write-Host "  FAIL $name field missing attribute $attr" -ForegroundColor Red
            }
        }
        $fieldName = $field.name
        if ($fieldName -and $seen.ContainsKey($fieldName)) {
            $failures += "${name}: duplicate field '$fieldName'"
            Write-Host "  FAIL $name duplicate field $fieldName" -ForegroundColor Red
        } elseif ($fieldName) {
            $seen[$fieldName] = $true
        }
    }
    Write-Host "  OK  $name ($($form.fields.Count) fields)" -ForegroundColor Green
}

# 5. Cross-references (validationRules field + uiMetadata section fields exist)
Write-Host "[5/5] Reference integrity..."
$refFailures = 0
foreach ($name in $forms.Keys) {
    $form = $forms[$name]
    $fieldNames = @($form.fields | ForEach-Object { $_.name })

    foreach ($vr in @($form.validationRules)) {
        $rootField = (($vr.field -replace '\*', '') -split '[.\[]')[0]
        if ($rootField -and $rootField -notin $fieldNames) {
            $refFailures++
            $failures += "${name}: validationRules field '$($vr.field)' not defined"
            Write-Host "  FAIL $name validationRules references unknown field $($vr.field)" -ForegroundColor Yellow
        }
        if ($vr.refField) {
            $rootRefField = ($vr.refField -replace '\*', '' -split '[.\[]')[0]
            if ($rootRefField -and $rootRefField -notin $fieldNames) {
                $refFailures++
                $failures += "${name}: validationRules refField '$($vr.refField)' not defined"
                Write-Host "  FAIL $name validationRules references unknown refField $($vr.refField)" -ForegroundColor Yellow
            }
        }
    }

    foreach ($section in @($form.uiMetadata.sections)) {
        foreach ($f in @($section.fields)) {
            if ($f -notin $fieldNames) {
                $refFailures++
                $failures += "${name}: uiMetadata section '$($section.id)' references unknown field '$f'"
                Write-Host "  FAIL $name uiMetadata references unknown field $f" -ForegroundColor Yellow
            }
        }
    }
}
if ($refFailures -eq 0) { Write-Host "  OK  all field references resolve" -ForegroundColor Green }

Write-Host ""
if ($failures.Count -eq 0) {
    Write-Host "RESULT: PASS - $($formFiles.Count) forms, $($schemaFiles.Count) schemas, registry consistent." -ForegroundColor Green
    exit 0
} else {
    Write-Host "RESULT: FAIL - $($failures.Count) issue(s)." -ForegroundColor Red
    $failures | ForEach-Object { Write-Host "  $_" }
    exit 1
}
