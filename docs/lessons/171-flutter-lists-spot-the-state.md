# Build efficient scrollable lists: Diagnose the state

**Topic:** Flutter  
**Summary:** Use lazy list construction, stable identity, and deliberate empty/loading states.

## Learning goal

Use lazy list construction, stable identity, and deliberate empty/loading states.

## How it works

`ListView.builder` constructs visible children on demand, making it suitable for long or dynamic collections. Stable keys help Flutter preserve element identity when items move. Keep row work bounded and avoid rebuilding the whole dataset unnecessarily.

## Worked example

Provide a stable key derived from the listing ID, use `ListView.builder`, and render separate loading, empty, and populated states. If reorder animations or stateful rows are important, provide item identity to the sliver delegate.

## Watch for

Index keys can attach state to the wrong item after insertions or reordering. Creating every row eagerly wastes work for large collections.

## Key terms

ListView.builder, lazy, Key, identity, sliver

## Practice context

Search results reorder after favorites change, but each row contains an input-like control that should retain the correct state.

## Exercise

Read the scenario and label the exact state or boundary involved. Explain what the observation proves and what it does not prove.

Scenario: Search results reorder after favorites change, but each row contains an input-like control that should retain the correct state.

Use this concept: `ListView.builder` constructs visible children on demand, making it suitable for long or dynamic collections. Stable keys help Flutter preserve element identity when items move. Keep row work bounded and avoid rebuilding the whole dataset unnecessarily.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Index keys can attach state to the wrong item after insertions or reordering. Creating every row eagerly wastes work for large collections.
