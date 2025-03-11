# Navigate commit history: Compare two approaches

**Topic:** Git  
**Summary:** Read the graph and locate changes without confusing history with the working tree.

## Learning goal

Read the graph and locate changes without confusing history with the working tree.

## How it works

Commits form a directed graph through parent references. `git log` walks ancestry; `--oneline --graph --decorate --all` gives a compact view of branches and references. A branch name points to a commit and advances as new commits are made.

## Worked example

Use `git log --oneline --graph --decorate --all` to orient yourself, then `git show <commit>` to inspect one snapshot and message. `git log -- lib/search.dart` narrows history by path.

## Watch for

The most recent commit is not always the most recent change to a particular file, and branch names move over time.

## Key terms

commit graph, ancestry, branch reference, git show

## Practice context

A bug appeared after last week's UI work, and two feature branches have since diverged.

## Exercise

Compare the recommended approach with one plausible alternative. Choose based on this scenario's ownership, safety, and maintenance needs.

Scenario: A bug appeared after last week's UI work, and two feature branches have since diverged.

Use this concept: Commits form a directed graph through parent references. `git log` walks ancestry; `--oneline --graph --decorate --all` gives a compact view of branches and references. A branch name points to a commit and advances as new commits are made.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: The most recent commit is not always the most recent change to a particular file, and branch names move over time.
