# Work with remotes: Debug a realistic mistake

**Topic:** Git  
**Summary:** Understand local branches, remote-tracking references, fetch, and push.

## Learning goal

Understand local branches, remote-tracking references, fetch, and push.

## How it works

A remote is a named connection such as `origin`. Fetch downloads objects and updates remote-tracking references like `origin/main`; it does not merge them into your current branch. Push publishes commits and updates a remote branch when permitted.

## Worked example

`git fetch origin` refreshes remote-tracking refs. Inspect `git log --oneline HEAD..origin/main`, integrate intentionally, then push your branch. `git remote -v` shows configured destinations.

## Watch for

A remote-tracking branch is a local record of observed remote state, not a live remote connection or your local branch.

## Key terms

remote, fetch, remote-tracking branch, push, upstream

## Practice context

Your local feature branch is based on yesterday's main, while a teammate has pushed a new API contract.

## Exercise

A colleague makes the pitfall described below. Identify the mistaken assumption, the likely symptom, and the least disruptive recovery.

Scenario: Your local feature branch is based on yesterday's main, while a teammate has pushed a new API contract.

Use this concept: A remote is a named connection such as `origin`. Fetch downloads objects and updates remote-tracking references like `origin/main`; it does not merge them into your current branch. Push publishes commits and updates a remote branch when permitted.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: A remote-tracking branch is a local record of observed remote state, not a live remote connection or your local branch.
