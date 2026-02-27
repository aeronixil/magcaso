# Navigate with explicit route data: Debug a realistic mistake

**Topic:** Flutter  
**Summary:** Pass the minimum stable identifier and load destination data at the destination.

## Learning goal

Pass the minimum stable identifier and load destination data at the destination.

## How it works

Navigation changes which route is visible and may create a stack of pages. A route should have an explicit contract. Passing a stable ID often avoids stale copies and oversized route arguments; the destination can load current data and handle missing records.

## Worked example

Navigate with `shopId`, load the latest shop record in the detail route, and represent loading, not-found, and error states. Define back behavior so filters and scroll position are preserved when expected.

## Watch for

Passing a large mutable object hides data freshness assumptions. Unvalidated deep-link parameters can refer to missing or unauthorized records.

## Key terms

route, Navigator, route argument, deep link, back stack

## Practice context

A search result opens a shop detail page, and the listing might be edited before the user returns.

## Exercise

A colleague makes the pitfall described below. Identify the mistaken assumption, the likely symptom, and the least disruptive recovery.

Scenario: A search result opens a shop detail page, and the listing might be edited before the user returns.

Use this concept: Navigation changes which route is visible and may create a stack of pages. A route should have an explicit contract. Passing a stable ID often avoids stale copies and oversized route arguments; the destination can load current data and handle missing records.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Passing a large mutable object hides data freshness assumptions. Unvalidated deep-link parameters can refer to missing or unauthorized records.
