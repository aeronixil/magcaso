# Test widgets through user-visible behavior: Compare two approaches

**Topic:** Flutter  
**Summary:** Arrange realistic dependencies and assert what a user can observe and do.

## Learning goal

Arrange realistic dependencies and assert what a user can observe and do.

## How it works

Widget tests build a subtree in a test environment and interact through finders and gestures. Strong tests assert visible behavior and meaningful state transitions while substituting slow or external dependencies at a clear seam.

## Worked example

Pump the widget with a fake repository, tap the labeled favorite control, pump the resulting frame, and assert its semantic selected state and one repository call. Add a rebuild to catch state tied to transient widget identity.

## Watch for

Tests coupled to private implementation details fail during harmless refactors. A test that only checks a widget exists misses behavior.

## Key terms

WidgetTester, finder, pump, fake dependency, semantics

## Practice context

A favorite button should update its selected state and call the save action once, even after the row rebuilds.

## Exercise

Compare the recommended approach with one plausible alternative. Choose based on this scenario's ownership, safety, and maintenance needs.

Scenario: A favorite button should update its selected state and call the save action once, even after the row rebuilds.

Use this concept: Widget tests build a subtree in a test environment and interact through finders and gestures. Strong tests assert visible behavior and meaningful state transitions while substituting slow or external dependencies at a clear seam.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Tests coupled to private implementation details fail during harmless refactors. A test that only checks a widget exists misses behavior.
