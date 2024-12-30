# Stage precise changes: Adapt the worked example

**Topic:** Git  
**Summary:** Use the index to assemble a reviewable commit.

## Learning goal

Use the index to assemble a reviewable commit.

## How it works

The index (also called the staging area) is a proposed next snapshot. A commit records the index, not every file currently modified on disk. Stage by path, inspect the staged diff, and adjust until the snapshot is coherent.

## Worked example

`git add lib/login.dart` stages one path. `git diff --cached` reviews exactly what the next commit would contain. `git restore --staged lib/login.dart` removes it from the index without discarding the working copy.

## Watch for

`git add .` may sweep unrelated files into a commit. Staging is reversible; committing is a separate action.

## Key terms

index, git add, staged diff, restore --staged

## Practice context

You changed a login form and also added an unrelated debug print to a shared utility file.

## Exercise

Change the scenario in one concrete way and adapt the example. Explain how the new constraint changes the command, widget structure, or state handling.

Scenario: You changed a login form and also added an unrelated debug print to a shared utility file.

Use this concept: The index (also called the staging area) is a proposed next snapshot. A commit records the index, not every file currently modified on disk. Stage by path, inspect the staged diff, and adjust until the snapshot is coherent.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: `git add .` may sweep unrelated files into a commit. Staging is reversible; committing is a separate action.
