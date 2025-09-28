# Magcaso Classroom

A Material 3 learning app with a 3D/AR model studio, searchable Git and Flutter lessons, topic filters,
favorites, readable lesson details, and light/dark themes. Favorites and appearance
are session-only and reset when the app restarts.

## Classroom history notice

The `codex/classroom-modernization` branch adds **252 simulated-date commits**
covering **2024-09-28 through 2026-09-28**. Commit subjects start with
`[classroom simulation]`; author and committer timestamps are teaching data.
The app upgrade is one commit, 250 commits add individual lessons, and the AR
model studio is inserted on the simulated date **2025-09-28**.
These timestamps do not represent when development actually occurred. The modern
Flutter SDK therefore appears even at the beginning of the simulated period.
The original repository history is retained as the branch's ancestor.

The classroom dates use a fixed random seed, mixing quiet stretches with days
containing several commits. Re-running the schedule produces the same pattern.
The local heatmap uses four green intensity levels to show daily commit counts.

## Run

Use the AR cube button in the lesson browser to view the astronaut and robot.
Supported mobile devices can launch AR placement; other browsers support 3D.
See [AR setup, device limitations and model credits](docs/AR.md).

Install Flutter **3.47.5** (Dart **3.13.4**), then:

```sh
flutter pub get
flutter run -d chrome
```

The committed lesson index includes 250 cards. To regenerate content:

```sh
python tools/build_curriculum.py --count 250
```

## Check and build

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web --release
```

CI runs these checks using the pinned SDK. Android uses Flutter's 3.47.5 template
versions (AGP 9.1.0, Gradle 9.3.1, Kotlin 2.4.0), Java 17, and SDK-managed compile
and target versions. Apple minimum deployment versions are iOS 15 and macOS 12.
Apple builds require macOS/Xcode. Android release signing is configured for
classroom debug keys; configure a distribution key before releasing an app.

Local upgrade validation: analysis and eight widget tests pass. Android compilation
could not complete on the preparation machine because Java could not establish a
loopback connection; the separate Android CI job checks the debug build on Linux.

## Show the activity timeline

```sh
python tools/render_activity.py
```

Open `docs/activity.html` in a browser. This generated, ignored file shows a green
heatmap computed from the branch's actual commit timestamps, with the simulation
notice visible. Hover on a square for the date and count.

The history generator supports a dry run and resumes an interrupted matching
commit sequence. Use it only from the original base with the prepared app changes
on `codex/classroom-modernization`:

```sh
python tools/create_training_history.py --base 5ea759ec65c0b6a9811e64f8b9df03f9e04f1051
# Add --execute to create the planned local commits.
```

The script never pushes, amends, rebases or resets existing history.
It generates the original 251 curriculum commits; the AR feature is a separate
historical insertion. The checker validates the full 252-commit timeline.
GitHub's profile graph has additional rules: commits normally need to be on the
default or gh-pages branch, the author email must belong to the account, and
repository eligibility and processing time also apply. A local branch or a
feature branch alone does not populate that profile graph.
See [GitHub contribution rules](https://docs.github.com/en/account-and-profile/how-tos/contribution-settings/troubleshooting-missing-contributions).

See [the classroom guide](docs/CLASSROOM.md) for teaching activities.
