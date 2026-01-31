# Choose local state deliberately: Plan a safe recovery

**Topic:** Flutter  
**Summary:** Use StatefulWidget for ephemeral state and keep updates inside lifecycle rules.

## Learning goal

Use StatefulWidget for ephemeral state and keep updates inside lifecycle rules.

## How it works

State that belongs to one widget instance can live in `State<T>`. Calling `setState` synchronously marks that subtree for a rebuild; it should wrap the state change, not expensive asynchronous work. Durable or shared state needs an owner with appropriate lifetime.

## Worked example

Initialize draft selection in `initState`, update it inside `setState`, and return the chosen value when Done is tapped. Cancel simply closes the sheet without mutating the applied filter.

## Watch for

Calling `setState` after disposal is invalid. Do not use a widget-local field for state that must survive navigation or be shared across screens.

## Key terms

State object, setState, initState, dispose, ephemeral state

## Practice context

A filter sheet has a temporary selected sort order and only applies it when the user presses Done.

## Exercise

Assume the operation is interrupted or the first attempt fails. Write a recovery sequence that preserves valuable work and confirms the final state.

Scenario: A filter sheet has a temporary selected sort order and only applies it when the user presses Done.

Use this concept: State that belongs to one widget instance can live in `State<T>`. Calling `setState` synchronously marks that subtree for a rebuild; it should wrap the state change, not expensive asynchronous work. Durable or shared state needs an owner with appropriate lifetime.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Calling `setState` after disposal is invalid. Do not use a widget-local field for state that must survive navigation or be shared across screens.
