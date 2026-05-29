# SI_ManageMSPvalues

> Invocable Apex action for managing multi-select picklist (MSP) string values in Flows.

---

## What it does

Adds or removes a value from a semicolon-separated multi-select picklist string and returns the updated string. Designed to be called from a Flow as an **Invocable Action**.

Because Salesforce Flows have no native way to surgically add or remove a single value from an MSP field without overwriting the whole string, this class handles the parsing, set manipulation, and reassembly.

---

## Inputs (`MSPRequest`)

| Parameter | Type | Required | Description |
|---|---|---|---|
| `mspString` | `String` | No | The current MSP field value (semicolon-separated). Pass `null` or blank to start fresh. |
| `value` | `String` | Yes | The individual value to add or remove. |
| `operation` | `String` | Yes | Either `add` or `remove` (case-insensitive). |

---

## Outputs (`MSPResponse`)

| Parameter | Type | Description |
|---|---|---|
| `updatedMspString` | `String` | The resulting semicolon-separated MSP string after the operation. |

---

## Behaviour notes

- Accepts a list of requests (bulk-safe).
- If `mspString` is blank or null, treats it as an empty set.
- `add`: inserts the value if not already present (set semantics — no duplicates).
- `remove`: removes the value if present; no-ops silently if not found.
- Values are trimmed before processing; `operation` is lowercased before comparison.
- Order of values in the output string is **not guaranteed** (uses a `Set` internally).

---

## Usage in Flow

1. Add an **Action** element to your Flow.
2. Search for `Manage MSP Values`.
3. Map your MSP field to **MSP String**, provide the **Value to Add or Remove**, and set **Operation** to `add` or `remove`.
4. Store the **Updated MSP String** output back to your record variable.

---

*Created by Jose De Oliveira — 2025-07-18*
