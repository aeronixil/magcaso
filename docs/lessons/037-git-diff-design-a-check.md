# Inspect diffs at the right boundary: Design a verification check

**Topic:** Git  
**Summary:** Compare working files, staged content, and commits.

## Learning goal

Compare working files, staged content, and commits.

## How it works

A diff is a comparison between two states. `git diff` compares working tree to index; `git diff --cached` compares index to HEAD; `git diff A..B` compares commit trees. The boundary determines which edits you see.

## Worked example

Use `git diff --check` for whitespace problems, `git diff --cached -- lib/feature.dart` for the proposed committed version of one path, and `git diff HEAD` to see all tracked differences from the current commit.

## Watch for

A clean `git diff` does not mean there are no changes: everything might already be staged.

## Key terms

diff, unified hunk, index, HEAD, pathspec

## Practice context

A reviewer says the feature looks complete, but you need to verify which exact changes would enter the commit.

## Exercise

Create a short checklist or test for the scenario. It must catch the pitfall and assert user-visible or repository-visible behavior rather than implementation trivia.

Scenario: A reviewer says the feature looks complete, but you need to verify which exact changes would enter the commit.

Use this concept: A diff is a comparison between two states. `git diff` compares working tree to index; `git diff --cached` compares index to HEAD; `git diff A..B` compares commit trees. The boundary determines which edits you see.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: A clean `git diff` does not mean there are no changes: everything might already be staged.
