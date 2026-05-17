# Build consistent Material themes: Diagnose the state

**Topic:** Flutter  
**Summary:** Centralize color, typography, and component defaults with theme extensions where needed.

## Learning goal

Centralize color, typography, and component defaults with theme extensions where needed.

## How it works

`ThemeData` provides inherited visual defaults. `ColorScheme` communicates semantic roles such as primary, surface, and error; component themes keep buttons, inputs, and cards consistent. Theme-aware widgets adapt when the app changes appearance.

## Worked example

Define light and dark `ThemeData` from coherent color schemes, set shared component themes, and read colors through `Theme.of(context)`. Use a `ThemeExtension` for brand tokens not represented by Material roles.

## Watch for

A raw brand color does not automatically have sufficient contrast or the right semantic meaning for every component.

## Key terms

ThemeData, ColorScheme, component theme, ThemeExtension, contrast

## Practice context

The booking flow has hand-picked colors on each page and contrast becomes inconsistent in dark mode.

## Exercise

Read the scenario and label the exact state or boundary involved. Explain what the observation proves and what it does not prove.

Scenario: The booking flow has hand-picked colors on each page and contrast becomes inconsistent in dark mode.

Use this concept: `ThemeData` provides inherited visual defaults. `ColorScheme` communicates semantic roles such as primary, surface, and error; component themes keep buttons, inputs, and cards consistent. Theme-aware widgets adapt when the app changes appearance.

A strong answer names a concrete action, the expected evidence, and how it avoids this pitfall: A raw brand color does not automatically have sufficient contrast or the right semantic meaning for every component.
