# Engine Integration Guide

How the main engine (AirLoad Station) consumes the form definition files in this library.

## 1. Directory layout

| Path | Contents | Purpose |
| --- | --- | --- |
| `config/form-registry.json` | Index of every form (code, name, category, status) | Discovery, catalogs, form pickers |
| `forms/F*.json` | One form definition per file | Schema of each form: fields, workflow, permissions, validation, UI/PDF metadata |
| `schemas/form.schema.json` | JSON Schema validating a form definition | Engine-side validation of the definitions themselves |
| `schemas/loadsheet.schema.json` | JSON Schema for W&B data (F020/F021) | Runtime validation of loadsheet payloads |
| `schemas/flight.schema.json` | JSON Schema for flight header data | Runtime validation of common flight fields |
| `schemas/passenger.schema.json` | JSON Schema for passenger record data | Runtime validation of passenger fields |
| `docs/*.md` | Catalog, architecture, workflow, data dictionary | Reference for integrators and operators |

## 2. Bootstrap flow

1. Load `config/form-registry.json` to enumerate available forms.
2. For each form code, load `forms/<code>_<slug>.json` to get its definition.
3. Optionally validate every definition against `schemas/form.schema.json`.
4. Build the runtime data model from `fields`, the rendering layout from `uiMetadata`, and PDF output from `pdfMetadata`.

Recommended service (Node):

```js
const registry = require('../config/form-registry.json');
const definitions = new Map();

for (const entry of registry.forms) {
  // map code -> definition. resolution order: registry order
  definitions.set(entry.code, null);
}
// load each definition lazily from forms/F001_*.json etc.
```

Note: an alternative is to keep a `forms/index.json` mapping `code -> filename` to avoid the code-prefix glob.

## 3. Form definition structure

```
formCode, name, version, category, status, sourceStatus
description
fields[]        -> data model (name/type/required/format/enum/items/properties)
workflow[]      -> ordered lifecycle states
permissions{}   -> role -> allowed actions
validationRules[] -> field/rule/message (+ value/refField/min/max)
uiMetadata{}    -> layout + UI sections (id/label/fields)
pdfMetadata{}   -> template/pageSize/orientation/copies/distribution
auditRequired, sourceReference, notes
```

### 3.1 `fields`
- `type`: `string | number | integer | boolean | object | array`
- `format`: `date | date-time | time | email | icao_code | hhmm | base64` (add codes as needed)
- `enum`: closed set of allowed values
- nested `properties`/`items`: structured sub-fields (mostly validation metadata only; the engine decides how deeply to model)
- `required`: runtime fill requirement, not JSON-Schema presence

### 3.2 `workflow`
Ordered list of states, e.g. `DRAFT, IN_PROGRESS, REVIEW, APPROVED, FINALIZED, ARCHIVED`.
Rules:
- `FINALIZED` operational records are immutable.
- Corrections create a new revision or controlled amendment.
- Every transition emits an audit event.
- Reprints never replace the original document.

### 3.3 `permissions`
`{ action: [role, ...] }`. Roles are generic (e.g. `LOAD_CONTROLLER`, `SENIOR_LOAD_CONTROLLER`, `PIC`).
Map your engine's concrete roles to these generic ones. `ALL` = any authenticated user.

### 3.4 `validationRules`
`{ field, rule, message, value?, refField?, min?, max?, minRef?, maxRef?, condition? }`.
- `rule` values are declarative; the engine owns the implementations.
- Some rules compare against computed/engine fields (e.g. `sumCompartmentPieces`, `maxTakeoffWeightKg`, `calculatedLoadFactorPct`) that are declared in `fields` and fed by the load-control/calculation engine.
- `condition` is an optional boolean expression that gates the rule.

## 4. Usage by the engine

### 4.1 Form instance lifecycle
1. **Instantiate**: copy the definition, create an empty data envelope per `fields` with `required`/`enum`/defaults.
2. **Validate**: run `validationRules`, plus payload JSON Schema where one exists.
3. **Transitions**: permit only steps in `workflow`; enforce `permissions`; record audit; make `FINALIZED` immutable.
4. **Render**: drive UI from `uiMetadata.sections`, PDF from `pdfMetadata`.

### 4.2 Canonical field names
Common header fields (`flightNumber`, `airlineCode`, `departureAirport`, `arrivalAirport`, `aircraftRegistration`, `operationalDate`, timestamps) are reused across nearly every form — see `docs/DATA_DICTIONARY.md`. Centralize mapping once in the engine, do not duplicate per form.

### 4.3 Units and timestamps
- Weights in **kg** unless the field says otherwise; CG in **% MAC** or **index units** (see `centerOfGravityReference`).
- Timestamps are **UTC** unless the field explicitly says `LOCAL`.
- Totals must equal the sum of their components (validated via rules referencing computed fields).

### 4.4 Compliance caveat
All definitions carry `sourceStatus: IMPLEMENTATION_TEMPLATE_NOT_OFFICIAL`. They are implementation templates, not reproductions of official ICAO/IATA/FAA/EASA forms. Verify every regulatory requirement against current authorized sources (IATA DGR/AHM editions, ICAO SARPs, State AIPs) before production use. Never label output as official unless rights and sources are verified.

## 5. Category → engine domains

| Category | Flag in registry | Primary engine domain |
| --- | --- | --- |
| dispatch | dispatch | Flight ops / dispatch |
| passenger, crew, checkin, boarding | passenger / crew / checkin / boarding | DCS |
| loadcontrol | loadcontrol | Weight & balance engine |
| dangerous_goods | dangerous_goods | Cargo / DG officer |
| ground, fuel, catering | ground / fuel / catering | Ground handler / station |
| border | border | Immigration / customs |
| airport | airport | Airport coordination / slots |
| maintenance, safety | maintenance / safety | M&E / SMS |
| reporting | reporting | Analytics |

## 6. Validation tooling

`tools/Validate-FormLibrary.ps1` checks: JSON parse-ability, schema parse-ability, registry⇄file 1:1 match, required top-level keys, duplicate fields, and reference integrity of `validationRules`/`uiMetadata`. Re-run after any change:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\Validate-FormLibrary.ps1
```