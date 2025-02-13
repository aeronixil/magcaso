# Make useful commits: Interpret evidence

**Topic:** Git  
**Summary:** Record coherent snapshots with messages that explain intent.

## Learning goal

Record coherent snapshots with messages that explain intent.

## How it works

A commit identifies a tree snapshot, its parent, metadata, and a message. Good commits group one understandable change and say why it exists; the staged index determines the tree.

## Worked example

Stage only the redesign, inspect `git diff --cached`, then commit with a message such as `Add accessible settings theme controls`. A second cleanup can be staged and committed separately.

## Watch for

A commit message like `updates` forces future readers to reconstruct intent from the diff. A commit does not include unstaged changes.

## Key terms

snapshot, parent, commit message, atomic change

## Practice context

You are splitting a settings-screen redesign from a formatting-only cleanup before handing work to a reviewer.

## Exercise

Use the example output or behavior as evidence. Describe what it establishes, what remains uncertain, and which next observation would reduce uncertainty.

Scenario: You are splitting a settings-screen redesign from a formatting-only cleanup before handing work to a reviewer.

Use this concept: A commit identifies a tree snapshot, its parent, metadata, and a message. Good commits group one understandable change and say why it exists; the staged index determines the tree.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: A commit message like `updates` forces future readers to reconstruct intent from the diff. A commit does not include unstaged changes.
