import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_desafio_app/components/components.dart';

void main() {
  testWidgets(
      'CustomButton filled constructor creates an ElevatedButton and triggers callback',
      (WidgetTester tester) async {
    bool pressed = false;

    // Build the CustomButton widget with the filled constructor
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            onPressed: () {
              pressed = true;
            },
            child: const Text('Filled Button'),
          ),
        ),
      ),
    );

    // Find the ElevatedButton by its type
    final elevatedButton = find.byType(ElevatedButton);

    // Verify that an ElevatedButton is built
    expect(elevatedButton, findsOneWidget);

    // Tap the ElevatedButton
    await tester.tap(elevatedButton);
    await tester.pump();

    // Verify the callback is triggered
    expect(pressed, isTrue);
  });

  testWidgets(
      'CustomButton outlined constructor creates an OutlinedButton with border and triggers callback',
      (WidgetTester tester) async {
    bool pressed = false;

    // Build the CustomButton widget with the outlined constructor
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton.outlined(
            onPressed: () {
              pressed = true;
            },
            borderColor: Colors.blue,
            child: const Text('Outlined Button'),
          ),
        ),
      ),
    );

    // Find the OutlinedButton by its type
    final outlinedButton = find.byType(OutlinedButton);

    // Verify that an OutlinedButton is built
    expect(outlinedButton, findsOneWidget);

    // Tap the OutlinedButton
    await tester.tap(outlinedButton);
    await tester.pump();

    // Verify the callback is triggered
    expect(pressed, isTrue);

    // Verify the border color is applied
    final outlinedButtonWidget = tester.widget<OutlinedButton>(outlinedButton);
    final borderSide = outlinedButtonWidget.style?.side?.resolve({});
    expect(borderSide?.color, equals(Colors.blue));
  });

  testWidgets(
      'CustomButton cancel constructor creates an OutlinedButton with red border and triggers callback',
      (WidgetTester tester) async {
    bool pressed = false;

    // Build the CustomButton widget with the cancel constructor
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton.cancel(
            onPressed: () {
              pressed = true;
            },
            child: const Text('Cancel Button'),
          ),
        ),
      ),
    );

    // Find the OutlinedButton by its type
    final cancelButton = find.byType(OutlinedButton);

    // Verify that an OutlinedButton is built
    expect(cancelButton, findsOneWidget);

    // Tap the OutlinedButton
    await tester.tap(cancelButton);
    await tester.pump();

    // Verify the callback is triggered
    expect(pressed, isTrue);

    // Verify the border color is red
    final cancelButtonWidget = tester.widget<OutlinedButton>(cancelButton);
    final borderSide = cancelButtonWidget.style?.side?.resolve({});
    expect(borderSide?.color, equals(Colors.red));
  });
}
