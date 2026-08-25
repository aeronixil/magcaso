# Separate UI from data access: Adapt the worked example

**Topic:** Flutter  
**Summary:** Use a repository boundary to make sources replaceable and screens testable.

## Learning goal

Use a repository boundary to make sources replaceable and screens testable.

## How it works

A repository gives the application a stable interface for loading and changing domain data, while hiding HTTP, caching, and parsing details. It lets widgets express user intent instead of constructing requests directly.

## Worked example

Define a `ListingRepository` method such as `searchListings(filters)`, implement transport and parsing behind it, and inject the interface into the screen. Map repository outcomes to UI states in one place.

## Watch for

A repository that merely renames every HTTP call without owning a useful boundary adds indirection but no clarity.

## Key terms

repository, dependency injection, data source, domain model

## Practice context

The listing screen currently builds URLs, parses response maps, and shows snackbars in one button callback.

## Exercise

Change the scenario in one concrete way and adapt the example. Explain how the new constraint changes the command, widget structure, or state handling.

Scenario: The listing screen currently builds URLs, parses response maps, and shows snackbars in one button callback.

Use this concept: A repository gives the application a stable interface for loading and changing domain data, while hiding HTTP, caching, and parsing details. It lets widgets express user intent instead of constructing requests directly.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: A repository that merely renames every HTTP call without owning a useful boundary adds indirection but no clarity.
