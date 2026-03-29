# Handle asynchronous UI states: Predict before acting

**Topic:** Flutter  
**Summary:** Represent loading, success, empty, and failure outcomes explicitly.

## Learning goal

Represent loading, success, empty, and failure outcomes explicitly.

## How it works

Network and disk operations complete later. UI state should represent the pending operation and all meaningful results. Async callbacks need to respect widget lifetime; errors should be surfaced in a useful, recoverable way.

## Worked example

Set loading before awaiting the repository, handle success and failure distinctly, and check `mounted` before updating disposed widget state. Prevent stale responses from an older query replacing newer results, for example with a request generation token.

## Watch for

A spinner alone is not an error strategy. Catching every error and showing an empty list falsely tells users that the search succeeded with no matches.

## Key terms

Future, await, loading, empty, error, mounted, stale response

## Practice context

A chair search request can return results, no matches, a server error, or finish after the search screen closes.

## Exercise

Write down the expected outcome of the example command or code change. Include the state that should remain untouched.

Scenario: A chair search request can return results, no matches, a server error, or finish after the search screen closes.

Use this concept: Network and disk operations complete later. UI state should represent the pending operation and all meaningful results. Async callbacks need to respect widget lifetime; errors should be surfaced in a useful, recoverable way.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: A spinner alone is not an error strategy. Catching every error and showing an empty list falsely tells users that the search succeeded with no matches.
