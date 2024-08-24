import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/components/components.dart';

void main() {
  testWidgets(
      'CustomSpace default constructor creates SizedBox with given height and width',
      (WidgetTester tester) async {
    // Build the CustomSpace widget with the default constructor
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomSpace(
            height: 10,
            width: 20,
          ),
        ),
      ),
    );

    // Find the SizedBox by its type
    final customSpace = find.byType(CustomSpace);

    // Verify that a SizedBox is built
    expect(customSpace, findsOneWidget);

    // Check the SizedBox's properties
    final customSpaceWidget = tester.widget<SizedBox>(customSpace);
    expect(customSpaceWidget.height, 10);
    expect(customSpaceWidget.width, 20);
  });

  testWidgets('CustomSpace.sp1 creates SizedBox with height and width of 4',
      (WidgetTester tester) async {
    // Build the CustomSpace.sp1 widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomSpace.sp1(),
        ),
      ),
    );

    // Find the SizedBox by its type
    final customSpace = find.byType(CustomSpace);

    // Verify that a SizedBox is built
    expect(customSpace, findsOneWidget);

    // Check the SizedBox's properties
    final sizedBoxWidget = tester.widget<SizedBox>(customSpace);
    expect(sizedBoxWidget.height, 4);
    expect(sizedBoxWidget.width, 4);
  });

  testWidgets('CustomSpace.sp2 creates SizedBox with height and width of 8',
      (WidgetTester tester) async {
    // Build the CustomSpace.sp2 widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomSpace.sp2(),
        ),
      ),
    );

    // Find the SizedBox by its type
    final customSpace = find.byType(CustomSpace);

    // Verify that a SizedBox is built
    expect(customSpace, findsOneWidget);

    // Check the SizedBox's properties
    final sizedBoxWidget = tester.widget<SizedBox>(customSpace);
    expect(sizedBoxWidget.height, 8);
    expect(sizedBoxWidget.width, 8);
  });

  testWidgets('CustomSpace.sp3 creates SizedBox with height and width of 12',
      (WidgetTester tester) async {
    // Build the CustomSpace.sp3 widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomSpace.sp3(),
        ),
      ),
    );

    // Find the SizedBox by its type
    final customSpace = find.byType(CustomSpace);

    // Verify that a SizedBox is built
    expect(customSpace, findsOneWidget);

    // Check the SizedBox's properties
    final sizedBoxWidget = tester.widget<SizedBox>(customSpace);
    expect(sizedBoxWidget.height, 12);
    expect(sizedBoxWidget.width, 12);
  });

  testWidgets('CustomSpace.sp4 creates SizedBox with height and width of 16',
      (WidgetTester tester) async {
    // Build the CustomSpace.sp4 widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomSpace.sp4(),
        ),
      ),
    );

    // Find the SizedBox by its type
    final customSpace = find.byType(CustomSpace);

    // Verify that a SizedBox is built
    expect(customSpace, findsOneWidget);

    // Check the SizedBox's properties
    final sizedBoxWidget = tester.widget<SizedBox>(customSpace);
    expect(sizedBoxWidget.height, 16);
    expect(sizedBoxWidget.width, 16);
  });
}
