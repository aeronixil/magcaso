# Branches as movable pointers: Compare two approaches

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

Compare the recommended approach with one plausible alternative. Choose based on this scenario's ownership, safety, and maintenance needs.

Scenario: You need to prototype a profile editor while keeping the main line ready for a small production fix.

Use this concept: A branch is a named pointer to a commit, not a copy of all files. New commits on the checked-out branch advance that pointer. `git switch -c` creates and checks out a branch in one step.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Uncommitted edits are not stored on a branch pointer. Git may prevent a switch if those edits would be overwritten.
