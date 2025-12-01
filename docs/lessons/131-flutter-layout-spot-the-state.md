# Reason about constraints and layout: Diagnose the state

**Topic:** Flutter  
**Summary:** Diagnose overflow by following constraints from parent to child.

## Learning goal

Diagnose overflow by following constraints from parent to child.

## How it works

Flutter layout is a one-pass conversation: constraints go down, sizes go up, and parents position children. A child must choose a size within its constraints. Flex widgets divide available main-axis space among children.

## Worked example

Wrap the flexible text in `Expanded` or `Flexible`, let it wrap or ellipsize intentionally, and keep the icon at a bounded size. Test the screen at narrow width and with long localized text.

## Watch for

`Expanded` requires a bounded main-axis constraint. Putting it inside a scroll view with unbounded height can trigger a layout exception.

## Key terms

BoxConstraints, bounded, main axis, Expanded, overflow

## Practice context

A narrow phone overflows when a long shop name shares a row with price and an action icon.

## Exercise

Read the scenario and label the exact state or boundary involved. Explain what the observation proves and what it does not prove.

Scenario: A narrow phone overflows when a long shop name shares a row with price and an action icon.

Use this concept: Flutter layout is a one-pass conversation: constraints go down, sizes go up, and parents position children. A child must choose a size within its constraints. Flex widgets divide available main-axis space among children.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: `Expanded` requires a bounded main-axis constraint. Putting it inside a scroll view with unbounded height can trigger a layout exception.
