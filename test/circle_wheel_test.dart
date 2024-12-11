import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:circle_wheel/circle_wheel.dart';
import 'dart:math' as math;

void main() {
  group('CircleWheel Widget Tests', () {
    testWidgets('Basic rendering test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CircleWheel(
            itemCount: 8,
            radius: 100,
            itemBuilder: (index, isAtHotspot) => Text('Item $index'),
            rotation: RadialRotation.none,
            canRotate: true,
            hotspotAngle: math.pi / 2,
            hotspotRange: math.pi / 6,
            rotationDuration: Duration(milliseconds: 300),
            rotationCurve: Curves.easeInOut,
            startAngle: 0,
          ),
        ),
      );

      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 7'), findsOneWidget);
    });

    testWidgets('Visibility control test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CircleWheel(
            itemCount: 8,
            radius: 100,
            renderOnlyVisible: true,
            visibilityStartAngle: 0,
            visibilityEndAngle: math.pi,
            itemBuilder: (index, isAtHotspot) => Container(
              width: 50,
              height: 50,
              child: Text('Item $index'),
            ),
            rotation: RadialRotation.none,
            canRotate: true,
            hotspotAngle: math.pi / 2,
            hotspotRange: math.pi / 6,
            startAngle: 0,
          ),
        ),
      );

      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 8'), findsNothing);
    });

    testWidgets('Hotspot detection test', (WidgetTester tester) async {
      bool hotspotEntered = false;
      bool hotspotExited = false;

      await tester.pumpWidget(
        MaterialApp(
          home: CircleWheel(
            itemCount: 8,
            radius: 100,
            itemBuilder: (index, isAtHotspot) => Text('Item $index'),
            rotation: RadialRotation.none,
            canRotate: true,
            hotspotAngle: math.pi / 2,
            hotspotRange: math.pi / 6,
            onItemEnterHotspot: (index) {
              hotspotEntered = true;
            },
            onItemExitHotspot: (index) {
              hotspotExited = true;
            },
            startAngle: 0,
          ),
        ),
      );

      final gesture = await tester.startGesture(const Offset(100, 100));
      await gesture.moveBy(const Offset(50, 0));
      await tester.pump();

      expect(hotspotEntered, true);
      expect(hotspotExited, false);
    });

    testWidgets('Multiple hotspots test', (WidgetTester tester) async {
      List<int> enteredHotspots = [];

      await tester.pumpWidget(
        MaterialApp(
          home: CircleWheel(
            itemCount: 8,
            radius: 100,
            multipleHotspots: [math.pi / 2, math.pi, 3 * math.pi / 2],
            hotspotRange: math.pi / 6,
            itemBuilder: (index, isAtHotspot) => Text('Item $index'),
            rotation: RadialRotation.none,
            canRotate: true,
            onItemEnterHotspot: (index) {
              enteredHotspots.add(index);
            },
            startAngle: 0,
          ),
        ),
      );

      final gesture = await tester.startGesture(const Offset(100, 100));
      await gesture.moveBy(const Offset(50, 0));
      await tester.pump();

      expect(enteredHotspots.isNotEmpty, true);
    });

    testWidgets('Rotation test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CircleWheel(
            itemCount: 8,
            radius: 100,
            canRotate: true,
            rotationEnabled: true,
            itemBuilder: (index, isAtHotspot) => Text('Item $index'),
            rotation: RadialRotation.none,
            hotspotAngle: math.pi / 2,
            hotspotRange: math.pi / 6,
            startAngle: 0,
          ),
        ),
      );

      // Test manual rotation
      final gesture = await tester.startGesture(const Offset(100, 100));
      await gesture.moveBy(const Offset(50, 0));
      await tester.pump();

      // Test auto rotation
      await tester.pumpWidget(
        MaterialApp(
          home: CircleWheel(
            itemCount: 8,
            radius: 100,
            autoRotate: true,
            autoRotateSpeed: 1.0,
            itemBuilder: (index, isAtHotspot) => Text('Item $index'),
            rotation: RadialRotation.none,
            canRotate: true,
            hotspotAngle: math.pi / 2,
            hotspotRange: math.pi / 6,
            startAngle: 0,
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('Item scaling test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CircleWheel(
            itemCount: 8,
            radius: 100,
            itemScale: 1.5,
            hotspotScale: 2.0,
            hotspotAngle: math.pi / 2,
            itemBuilder: (index, isAtHotspot) => Container(
              width: 50,
              height: 50,
              child: Text('Item $index'),
            ),
            rotation: RadialRotation.none,
            canRotate: true,
            hotspotRange: math.pi / 6,
            startAngle: 0,
          ),
        ),
      );

      expect(find.byType(Transform), findsWidgets);
    });

    testWidgets('Bounce back test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CircleWheel(
            itemCount: 8,
            radius: 100,
            bounceBack: true,
            rotationResistance: 1.0,
            itemBuilder: (index, isAtHotspot) => Text('Item $index'),
            rotation: RadialRotation.none,
            canRotate: true,
            hotspotAngle: math.pi / 2,
            hotspotRange: math.pi / 6,
            startAngle: 0,
          ),
        ),
      );

      // Test bounce back behavior
      final gesture = await tester.startGesture(const Offset(100, 100));
      await gesture.moveBy(const Offset(100, 0));
      await gesture.up();
      await tester.pump();
      await tester.pumpAndSettle();
    });

    testWidgets('Snap to hotspot test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CircleWheel(
            itemCount: 8,
            radius: 100,
            snapToHotspot: true,
            hotspotAngle: math.pi / 2,
            itemBuilder: (index, isAtHotspot) => Text('Item $index'),
            rotation: RadialRotation.none,
            canRotate: true,
            hotspotRange: math.pi / 6,
            startAngle: 0,
          ),
        ),
      );

      // Test snap behavior
      final gesture = await tester.startGesture(const Offset(100, 100));
      await gesture.moveBy(const Offset(50, 0));
      await gesture.up();
      await tester.pumpAndSettle();
    });

    testWidgets('Performance options test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CircleWheel(
            itemCount: 8,
            radius: 100,
            renderOnlyVisible: true,
            itemBuilder: (index, isAtHotspot) => Text('Item $index'),
            rotation: RadialRotation.none,
            canRotate: true,
            hotspotAngle: math.pi / 2,
            hotspotRange: math.pi / 6,
            startAngle: 0,
          ),
        ),
      );

      expect(find.byType(Text), findsWidgets);
    });
  });
}
