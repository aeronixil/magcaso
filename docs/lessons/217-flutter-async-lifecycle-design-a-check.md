# Respect widget lifecycle: Design a verification check

**Topic:** Flutter  
**Summary:** Initialize and release resources at the correct lifecycle boundary.

## Learning goal

Initialize and release resources at the correct lifecycle boundary.

## How it works

A State object can initialize controllers and subscriptions in `initState`, respond to changed widget inputs in `didUpdateWidget`, and release resources in `dispose`. Async work may outlive the State, so cancel or guard it.

## Worked example

Create the controller and subscription with the State, cancel the subscription and dispose the controller in `dispose`, and replace the subscription if its booking ID changes in `didUpdateWidget`.

## Watch for

Disposing shared resources owned by another object breaks that owner. Merely checking `mounted` prevents setState after disposal but may not cancel wasted work.

## Key terms

initState, didUpdateWidget, dispose, subscription, ownership

## Practice context

A detail page listens to a live booking stream and also owns a scroll controller.

## Exercise

Create a short checklist or test for the scenario. It must catch the pitfall and assert user-visible or repository-visible behavior rather than implementation trivia.

Scenario: A detail page listens to a live booking stream and also owns a scroll controller.

Use this concept: A State object can initialize controllers and subscriptions in `initState`, respond to changed widget inputs in `didUpdateWidget`, and release resources in `dispose`. Async work may outlive the State, so cancel or guard it.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Disposing shared resources owned by another object breaks that owner. Merely checking `mounted` prevents setState after disposal but may not cancel wasted work.
