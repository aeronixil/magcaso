# Choose the safe undo operation: Adapt the worked example

**Topic:** Git  
**Summary:** Restore files, unstage content, or reverse a published commit deliberately.

## Learning goal

Restore files, unstage content, or reverse a published commit deliberately.

## How it works

Different undo commands affect different state. `restore` changes paths in the working tree or index; `reset` moves a branch pointer and may alter the index; `revert` creates a new commit that reverses an earlier commit.

## Worked example

Use `git revert <commit>` to record an inverse change on shared history. Use `git restore -- path` only when discarding that working-tree content is intended. Inspect status and diffs before destructive restoration.

## Watch for

`reset --hard` discards staged and unstaged tracked edits. Rewriting a shared branch can disrupt collaborators.

## Key terms

restore, reset, revert, shared history

## Practice context

A bad commit has already been pushed to a shared release branch and must be corrected without rewriting teammates' history.

## Exercise

Change the scenario in one concrete way and adapt the example. Explain how the new constraint changes the command, widget structure, or state handling.

Scenario: A bad commit has already been pushed to a shared release branch and must be corrected without rewriting teammates' history.

Use this concept: Different undo commands affect different state. `restore` changes paths in the working tree or index; `reset` moves a branch pointer and may alter the index; `revert` creates a new commit that reverses an earlier commit.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: `reset --hard` discards staged and unstaged tracked edits. Rewriting a shared branch can disrupt collaborators.
