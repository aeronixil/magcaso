# Compose a widget tree: Plan a safe recovery

**Topic:** Flutter  
**Summary:** Model a screen as immutable widget descriptions composed from small pieces.

## Learning goal

Model a screen as immutable widget descriptions composed from small pieces.

## How it works

Flutter builds UI from widgets arranged in a tree. A widget is an immutable configuration; elements and render objects manage identity, lifecycle, and layout behind it. Small widgets with clear inputs make screens easier to reason about.

## Worked example

Compose `Card` → `Padding` → `Column` and use `Row` for title and price. Extract a `ListingCard` widget with required listing data and an explicit favorite callback rather than reaching into unrelated global state.

## Watch for

A widget is not the rendered pixel object and rebuilding a widget configuration is normal. Avoid enormous build methods with mixed responsibilities.

## Key terms

widget, element, render object, composition, build

## Practice context

A listing card needs a title, daily price, favorite button, and optional distance label.

## Exercise

Assume the operation is interrupted or the first attempt fails. Write a recovery sequence that preserves valuable work and confirms the final state.

Scenario: A listing card needs a title, daily price, favorite button, and optional distance label.

Use this concept: Flutter builds UI from widgets arranged in a tree. A widget is an immutable configuration; elements and render objects manage identity, lifecycle, and layout behind it. Small widgets with clear inputs make screens easier to reason about.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: A widget is not the rendered pixel object and rebuilding a widget configuration is normal. Avoid enormous build methods with mixed responsibilities.
