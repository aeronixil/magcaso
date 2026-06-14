# Make controls accessible: Predict before acting

**Topic:** Flutter  
**Summary:** Provide meaningful labels, adequate targets, contrast, and non-color status cues.

## Learning goal

Provide meaningful labels, adequate targets, contrast, and non-color status cues.

## How it works

Accessible UI exposes purpose and state to assistive technology and remains usable with different input and visual conditions. Flutter semantics describe controls; touch targets and contrast matter even when the UI looks polished on one device.

## Worked example

Use an `IconButton` with a descriptive tooltip and semantic label, expose toggled state with an appropriate control, and keep the tap target comfortably sized. Verify that favorite and unfavorite are distinguishable without color alone.

## Watch for

Wrapping everything in `Semantics` can duplicate announcements. Test actual focus and reading order instead of adding labels indiscriminately.

## Key terms

Semantics, label, tooltip, target size, contrast, focus order

## Practice context

A heart icon toggles a favorite, but currently has no text label and color is its only state signal.

## Exercise

Write down the expected outcome of the example command or code change. Include the state that should remain untouched.

Scenario: A heart icon toggles a favorite, but currently has no text label and color is its only state signal.

Use this concept: Accessible UI exposes purpose and state to assistive technology and remains usable with different input and visual conditions. Flutter semantics describe controls; touch targets and contrast matter even when the UI looks polished on one device.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: Wrapping everything in `Semantics` can duplicate announcements. Test actual focus and reading order instead of adding labels indiscriminately.
