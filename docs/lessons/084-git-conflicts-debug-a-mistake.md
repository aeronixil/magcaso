# Resolve merge conflicts: Debug a realistic mistake

**Topic:** Git  
**Summary:** Use conflict markers and the three inputs to preserve intended behavior.

## Learning goal

Use conflict markers and the three inputs to preserve intended behavior.

## How it works

A conflict means Git cannot automatically combine edits. Conflict markers delimit the current side (`HEAD`), the incoming side, and the shared base context. The correct resolution may combine, select, or rewrite both contributions.

## Worked example

Open the conflicted file, understand both versions, produce the intended final code without marker lines, run the relevant check, then `git add` the resolved path and complete the merge. `git merge --abort` returns to the pre-merge state if you need to restart.

## Watch for

Choosing 'ours' or 'theirs' blindly can erase valid behavior. Markers left in source are syntax errors and semantic mistakes.

## Key terms

conflict marker, ours, theirs, merge base, abort

## Practice context

Two branches change the same validation message: one improves plain language and the other adds a translation key.

## Exercise

A colleague makes the pitfall described below. Identify the mistaken assumption, the likely symptom, and the least disruptive recovery.

Scenario: Two branches change the same validation message: one improves plain language and the other adds a translation key.

Use this concept: A conflict means Git cannot automatically combine edits. Conflict markers delimit the current side (`HEAD`), the incoming side, and the shared base context. The correct resolution may combine, select, or rewrite both contributions.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Choosing 'ours' or 'theirs' blindly can erase valid behavior. Markers left in source are syntax errors and semantic mistakes.
