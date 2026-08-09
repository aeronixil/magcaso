# Model API data defensively: Plan a safe recovery

**Topic:** Flutter  
**Summary:** Parse external JSON with explicit types, validation, and useful failure context.

## Learning goal

Parse external JSON with explicit types, validation, and useful failure context.

## How it works

JSON is untrusted dynamic input. Convert it at the boundary into typed domain objects, validate required fields and formats, and keep serialization rules explicit. A failed parse should identify the field or record without leaking sensitive payloads.

## Worked example

Write a `fromJson` factory that checks numeric types, handles nullable image URLs, parses dates deliberately, and documents a backward-compatible default only when the product contract defines one.

## Watch for

Blind `as` casts crash at runtime and treating missing data as a plausible zero can misrepresent price or availability.

## Key terms

JSON boundary, factory, nullability, serialization, validation

## Practice context

An API returns a chair price as a number, an optional image URL, and an ISO date that may be absent in old records.

## Exercise

Assume the operation is interrupted or the first attempt fails. Write a recovery sequence that preserves valuable work and confirms the final state.

Scenario: An API returns a chair price as a number, an optional image URL, and an ISO date that may be absent in old records.

Use this concept: JSON is untrusted dynamic input. Convert it at the boundary into typed domain objects, validate required fields and formats, and keep serialization rules explicit. A failed parse should identify the field or record without leaking sensitive payloads.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Blind `as` casts crash at runtime and treating missing data as a plausible zero can misrepresent price or availability.
