# Branches as movable pointers: Plan a safe recovery

**Topic:** Git  
**Summary:** Create and switch lines of work while preserving committed snapshots.

## Learning goal

Create and switch lines of work while preserving committed snapshots.

## How it works

A branch is a named pointer to a commit, not a copy of all files. New commits on the checked-out branch advance that pointer. `git switch -c` creates and checks out a branch in one step.

## Worked example

Start with `git switch -c feature/profile-editor`. `git branch --show-current` confirms where commits will land. Switching branches changes the checked-out snapshot when Git can do so safely.

## Watch for

Uncommitted edits are not stored on a branch pointer. Git may prevent a switch if those edits would be overwritten.

## Key terms

branch, HEAD, switch, branch pointer

## Practice context

You need to prototype a profile editor while keeping the main line ready for a small production fix.

## Exercise

Assume the operation is interrupted or the first attempt fails. Write a recovery sequence that preserves valuable work and confirms the final state.

Scenario: You need to prototype a profile editor while keeping the main line ready for a small production fix.

Use this concept: A branch is a named pointer to a commit, not a copy of all files. New commits on the checked-out branch advance that pointer. `git switch -c` creates and checks out a branch in one step.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Uncommitted edits are not stored on a branch pointer. Git may prevent a switch if those edits would be overwritten.
