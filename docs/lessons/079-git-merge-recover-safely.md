# Merge compatible work: Plan a safe recovery

**Topic:** Git  
**Summary:** Combine branch histories and recognize fast-forward and merge commits.

## Learning goal

Combine branch histories and recognize fast-forward and merge commits.

## How it works

Merging incorporates another branch's reachable commits. If the current branch is an ancestor of the other, Git can fast-forward its pointer. Diverged histories need a merge commit that has both tips as parents.

## Worked example

Switch to the destination branch and run `git merge fix/contrast`. Review the resulting status and history. A fast-forward needs no merge commit; diverged changes may produce one.

## Watch for

Merging into the wrong checked-out branch changes the wrong line of work. Confirm `git branch --show-current` first.

## Key terms

merge base, fast-forward, merge commit, destination branch

## Practice context

A validated color-contrast fix is ready to join the main branch after another independent copy update.

## Exercise

Assume the operation is interrupted or the first attempt fails. Write a recovery sequence that preserves valuable work and confirms the final state.

Scenario: A validated color-contrast fix is ready to join the main branch after another independent copy update.

Use this concept: Merging incorporates another branch's reachable commits. If the current branch is an ancestor of the other, Git can fast-forward its pointer. Diverged histories need a merge commit that has both tips as parents.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Merging into the wrong checked-out branch changes the wrong line of work. Confirm `git branch --show-current` first.
