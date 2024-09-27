import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magcaso/main.dart';

const lessons = [
  Lesson(
    id: 'git-status',
    title: 'Read status as a change map',
    topic: 'Git',
    summary: 'Interpret status output before staging or committing.',
    body:
        '## How it works\n\n`git status` shows tracked and untracked changes.',
    exercise: 'Explain what `??` means in a status report.',
  ),
  Lesson(
    id: 'flutter-widgets',
    title: 'Compose a Flutter screen',
    topic: 'Flutter',
    summary: 'Build a screen by composing small widgets.',
    body: 'Start with a `Scaffold` and add focused widgets.',
    exercise: 'Sketch a screen using `Column` and `Text`.',
  ),
];

void main() {
  testWidgets('browses Git and Flutter lessons and renders Markdown detail', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp(initialLessons: lessons));
    await tester.pumpAndSettle();

    expect(find.text('Read status as a change map'), findsOneWidget);
    expect(find.text('Compose a Flutter screen'), findsOneWidget);
    await tester.tap(find.text('Read status as a change map'));
    await tester.pumpAndSettle();

    expect(find.text('How it works'), findsOneWidget);
    expect(find.text('## How it works'), findsNothing);
    expect(find.textContaining('git status'), findsOneWidget);
  });

  testWidgets('search and topic chips narrow the lesson list', (tester) async {
    await tester.pumpWidget(const MyApp(initialLessons: lessons));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'status');
    await tester.pumpAndSettle();
    expect(find.text('Read status as a change map'), findsOneWidget);
    expect(find.text('Compose a Flutter screen'), findsNothing);

    await tester.tap(find.text('All topics'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Flutter'));
    await tester.pumpAndSettle();
    expect(find.text('No lessons found'), findsOneWidget);
  });

  testWidgets('favorites can be saved and filtered, and theme can toggle', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp(initialLessons: lessons));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Add favorite').first);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Show favorites'));
    await tester.pumpAndSettle();
    expect(find.text('Read status as a change map'), findsOneWidget);
    expect(find.text('Compose a Flutter screen'), findsNothing);

    await tester.tap(find.byTooltip('Toggle appearance'));
    await tester.pumpAndSettle();
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
  });

  testWidgets('shows an empty classroom state', (tester) async {
    await tester.pumpWidget(const MyApp(initialLessons: []));
    await tester.pumpAndSettle();
    expect(find.text('Your classroom is ready'), findsOneWidget);
  });

  testWidgets('loads the bundled curriculum through the real asset loader', (
    tester,
  ) async {
    // Asset IO and large JSON decoding need real asynchronous time, not just
    // the widget test's fake frame clock.
    final source = await tester.runAsync(
      () => rootBundle.loadString('assets/lessons/index.json'),
    );
    final cards = jsonDecode(source!) as List<dynamic>;
    await tester.runAsync(() async {
      await tester.pumpWidget(const MyApp());
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pumpAndSettle();
    if (cards.isEmpty) {
      expect(find.text('Your classroom is ready'), findsOneWidget);
    } else {
      expect(find.text('${cards.length} lessons'), findsOneWidget);
      expect(find.text(cards.first['title'] as String), findsOneWidget);
    }
  });

  testWidgets('adapts lesson cards to a narrow viewport and larger text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5267D8)),
          useMaterial3: true,
        ),
        home: MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(1.4)),
          child: HomePage(initialLessons: lessons, onToggleTheme: () {}),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Read status as a change map'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.text('Read status as a change map'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
