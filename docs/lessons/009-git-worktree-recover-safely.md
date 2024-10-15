# The working tree and repository: Plan a safe recovery

**Topic:** Git  
**Summary:** Distinguish the files on disk, Git metadata, and the repository root.

## Learning goal

Distinguish the files on disk, Git metadata, and the repository root.

## How it works

A repository is a working directory plus Git's database in .git. The working tree is the checked-out files you edit. Git status compares those files and the index with the current commit; it does not automatically save edits.

## Worked example

Run `git rev-parse --show-toplevel` to find the repository root and `git status --short` to see working-tree changes. A leading `??` means an untracked path; ` M` means a tracked file differs from the index.

## Watch for

A folder containing source files is not necessarily the repository root. Commands run from a nested directory still operate on its containing repository unless a different repository is found.

## Key terms

repository root, working tree, .git, tracked, untracked

## Practice context

A teammate edits lib/cart.dart and creates notes/release.md, then asks why neither appears in the last commit.

## Exercise

Assume the operation is interrupted or the first attempt fails. Write a recovery sequence that preserves valuable work and confirms the final state.

Scenario: A teammate edits lib/cart.dart and creates notes/release.md, then asks why neither appears in the last commit.

Use this concept: A repository is a working directory plus Git's database in .git. The working tree is the checked-out files you edit. Git status compares those files and the index with the current commit; it does not automatically save edits.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: A folder containing source files is not necessarily the repository root. Commands run from a nested directory still operate on its containing repository unless a different repository is found.
