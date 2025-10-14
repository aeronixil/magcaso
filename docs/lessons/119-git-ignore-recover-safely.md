# Keep generated and private files out: Plan a safe recovery

**Topic:** Git  
**Summary:** Use ignore rules correctly and distinguish ignored files from tracked files.

## Learning goal

Use ignore rules correctly and distinguish ignored files from tracked files.

## How it works

`.gitignore` patterns prevent matching untracked paths from being offered for tracking. They do not remove files already in Git's index. Specific patterns and directory rules make intent easier to audit.

## Worked example

Add an appropriate `.gitignore` pattern for generated output. `git check-ignore -v path` explains a matching rule. For a tracked file that should remain locally, remove it from the index with `git rm --cached path` and commit that change.

## Watch for

Ignoring a tracked secret does not erase it from history or stop future commits from tracking it.

## Key terms

pattern, negation, tracked file, git check-ignore

## Practice context

A local Flutter build creates `.dart_tool/`, and a developer accidentally added a private signing configuration earlier.

## Exercise

Assume the operation is interrupted or the first attempt fails. Write a recovery sequence that preserves valuable work and confirms the final state.

Scenario: A local Flutter build creates `.dart_tool/`, and a developer accidentally added a private signing configuration earlier.

Use this concept: `.gitignore` patterns prevent matching untracked paths from being offered for tracking. They do not remove files already in Git's index. Specific patterns and directory rules make intent easier to audit.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Ignoring a tracked secret does not erase it from history or stop future commits from tracking it.
