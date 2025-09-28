import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magcaso/screens/ar_gallery.dart';

void main() {
  testWidgets('switches models, toggles rotation, and reloads the viewer', (
    tester,
  ) async {
    var builds = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: ArGalleryPage(
          viewerBuilder: (context, model, rotate) {
            builds++;
            return Center(child: Text('viewer:${model.id}:$rotate'));
          },
        ),
      ),
    );
    expect(find.text('viewer:astronaut:true'), findsOneWidget);
    await tester.tap(find.text('Expressive robot'));
    await tester.pump();
    expect(find.text('viewer:robot:true'), findsOneWidget);
    await tester.ensureVisible(find.byType(Switch));
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(find.text('viewer:robot:false'), findsOneWidget);
    final before = builds;
    await tester.tap(find.text('Reload model'));
    await tester.pump();
    expect(builds, greaterThan(before));
  });

  testWidgets('AR studio fits a narrow screen with enlarged text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.5)),
          child: child!,
        ),
        home: ArGalleryPage(viewerBuilder: (_, model, _) => Text(model.id)),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('3D & AR studio'), findsOneWidget);
  });
}
