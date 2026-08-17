# AirLoad Station

Offline weight &amp; balance and loadsheet production for airline station desks.

Runs entirely on one Windows PC. No internet connection, no database to
install, no server to reach. It is intended for stations that have to dispatch
a flight whether or not the network is up.

---

## Download

The latest installer is under [`station/releases`](station/releases), and
[`station/latest.json`](station/latest.json) records the current version and
its SHA-256.

The application itself can check this file — **Check for updates** in the top
right — and will tell you when a newer version exists. It never downloads or
installs anything on its own.

### Verifying what you downloaded

```powershell
Get-FileHash .\AirLoadStation-Setup-1.0.0.exe -Algorithm SHA256
```

The result must match the `sha256` in `station/latest.json`. If it does not,
do not run it.

---

## What it does

- **Weight &amp; balance** from your own AHM 514 aircraft data — zero fuel,
  ramp, takeoff and landing weights, moments, index, %MAC and the stabiliser
  trim setting, checked against the aircraft's CG envelope and structural
  limits.
- **Loadsheets** as a printable PDF and as an IATA AHM 565 Type B message.
- **Last minute changes** recorded against a released loadsheet, up to the cap
  in your operations manual.

The calculation engine is the same code as the full AirLoad Pro system, so a
loadsheet produced offline and one produced online agree by construction.

## What it deliberately does not do

- **It ships with no aircraft data.** Nothing is calculated until you load your
  own AHM 514 configuration. The application will not guess an aircraft's
  weights, arms, envelope or trim table, and there is no sample that could be
  mistaken for a real aircraft.
- **It does not release a loadsheet outside the envelope**, and it does not
  record a last minute change that breaches your cap, a structural limit, or
  the CG envelope. In those cases it requires a new loadsheet instead.
- **It does not synchronise.** Loadsheets released here stay here. Each one
  carries a checksum so a copy transferred by hand can be verified.
- **It listens on this computer only** (127.0.0.1). It has no login, so it is
  not exposed to other machines on the network.

---

## Installing

1. Download the installer and verify its checksum.
2. Run it. Administrator rights are needed because it installs for all users of
   the PC — station desks are usually shared across a shift.
3. Launch **AirLoad Station** from the Start menu.
4. Open the **Aircraft** tab and paste your AHM 514 configuration.

If the installer you were given does not bundle a runtime, Node.js 20 or later
must already be installed. The bundled installer states which it is on the
first page.

## Your data

```
%USERPROFILE%\AirLoadStation
```

Aircraft configurations and every released loadsheet, as plain JSON files.
Back it up by copying the folder. Uninstalling does **not** delete it.

---

## Support and licensing

This repository carries the released installers and end-user documentation
only. The application source is not published here.

For the full AirLoad Pro departure control system — check-in, boarding,
baggage, cargo, and regulatory filing — contact your supplier.
