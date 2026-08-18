# Core Data Dictionary

Common fields reused across form definitions (aviation-form-library). Field names are canonical; instances must specify types and required flags in each form definition.

## Flight / Operational Header

flightNumber: operator flight identifier.
airlineCode: configured airline designator.
departureAirport: IATA/ICAO airport code according to context.
arrivalAirport: IATA/ICAO airport code according to context.
alternateAirport: alternate airport ICAO code.
aircraftRegistration: aircraft registration.
aircraftType: ICAO aircraft type designator.
operationalDate: date of operation (format: date).
scheduledDeparture: scheduled departure timestamp.
estimatedDeparture: estimated departure timestamp.
actualDeparture: actual departure timestamp.
scheduledArrival: scheduled arrival timestamp.
actualArrival: actual arrival timestamp.
scheduledDepartureTime: scheduled time of departure (UTC).

## Passengers

passengerCount: number of passengers in the relevant category.
givenName / familyName: passenger name parts.
title: passenger title (MR, MRS, MS, MSTR, DR, CAPT, REV).
dateOfBirth: passenger date of birth.
gender: M, F, X, U.
nationality: nationality ISO-3 code.
documentType / documentNumber / documentExpiry / documentCountry: travel document identifiers.
seat: seat assignment.
class: cabin class code (F, C, J, W, Y).
sequenceNumber: check-in sequence number.
ssrCodes: IATA special service request codes.
boardingStatus: NOT_CHECKED_IN, CHECKED_IN, BOARDED, NO_SHOW, GO_SHOW, OFFLOADED.

## Baggage

baggageCount / totalPieces: number of bags.
baggageWeightKg: baggage mass in kilograms.
tagNumber: baggage tag identifier.
excessWeightKg: overweight baggage mass.
uncheckedBaggageCount: carry-on count.

## Cargo & Mail

cargoWeightKg: cargo mass in kilograms.
mailWeightKg: mail mass in kilograms.
uldId / uldType: unit load device identifier/type.
awbNumber: air waybill number.
dgClass / unId / packingGroup: dangerous goods identifiers (see Dangerous Goods).

## Weights & Balance (Load Control)

dryOperatingWeight: dry operating weight.
dryOperatingIndex: dry operating index.
zeroFuelWeightKg: zero-fuel weight.
takeoffWeightKg: takeoff weight.
landingWeightKg: landing weight.
centerOfGravity: CG value with explicit reference system (e.g., % MAC).
takeoffIndex / landingIndex / zeroFuelIndex: CG index units.
maxTakeoffWeightKg / maxLandingWeightKg / maxZeroFuelWeightKg: certified limits.
underloadKg: difference between limit and load.
fuelWeightKg: total fuel mass.
tripFuelKg / taxiFuelKg / contingencyFuelKg / alternateFuelKg / finalReserveFuelKg / extraFuelKg: fuel plan breakdown.

## Dangerous Goods

properShippingName: DG proper shipping name.
technicalName: technical name if required.
unId: UN number.
className: DG class (1-9).
subsidiaryRisk: subsidiary hazard class.
packingGroup: packing group (I, II, III).
packingInstruction: DGR packing instruction.
notocEntry: NOTOC line item (see F030).

## Authorities / Border

declarationNumber: unique declaration identifier.
apiSubmissionTime: API batch submission time.
passportNumber / passportCountry / passportExpiry: travel document data.
visaNumber / visaCountry / visaExpiry: visa data.

## Personnel / Authorization

preparedBy: person who prepared the form.
preparedTime: preparation timestamp.
authorizedBy / authorizedTime: authorization signature/time.
captainName / captainSignature: commander details.
loadControlOfficer: responsible load controller.
reportedBy: reporting person.

## Numbers & Units Rules

All weight and balance fields must identify units (kg unless stated) and aircraft configuration.
All timestamps are UTC unless a field explicitly specifies LOCAL.
Summation fields (totals) must be validated against their component fields.
Never invent a regulatory requirement; mark unknown requirements CONFIGURABLE or NEEDS_VERIFICATION.