# Read status as a change map: Teach it back

**Topic:** Git  
**Summary:** Interpret status output before staging or committing.

## Learning goal

Interpret status output before staging or committing.

## How it works

`git status` describes differences in two columns: the first is the index compared with HEAD, and the second is the working tree compared with the index. `??` marks a path Git has not begun tracking.

## Worked example

The theme change is staged; the home change is unstaged; scratch.txt is untracked. `git diff --cached` inspects the staged theme change, while `git diff` inspects the unstaged home change.

## Watch for

The two status columns are easy to conflate. A staged change can coexist with later unstaged edits to the same file.

## Key terms

HEAD, index, staged, unstaged, untracked

## Practice context

A status report shows `M  lib/theme.dart`, ` M lib/home.dart`, and `?? scratch.txt`.

## Exercise

Explain the idea to a teammate in your own words, then give one specific rule of thumb and one case where that rule needs an exception.

Scenario: A status report shows `M  lib/theme.dart`, ` M lib/home.dart`, and `?? scratch.txt`.

Use this concept: `git status` describes differences in two columns: the first is the index compared with HEAD, and the second is the working tree compared with the index. `??` marks a path Git has not begun tracking.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: The two status columns are easy to conflate. A staged change can coexist with later unstaged edits to the same file.
