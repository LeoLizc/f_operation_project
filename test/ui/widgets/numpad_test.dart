import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:f_operation_project/ui/widgets/numpad.dart'; // Asegúrate de importar el archivo con el widget

void main() {
  group('Numpad Widget', () {
    testWidgets('Renders buttons correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Numpad(
              onKeyPressed: (value) {},
              onClearPressed: () {},
              onGoPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('6'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);
      expect(find.text('8'), findsOneWidget);
      expect(find.text('9'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
      expect(find.text('GO'), findsOneWidget);
    });

    testWidgets('Buttons trigger correct callbacks',
        (WidgetTester tester) async {
      String keyPressed = '';
      bool clearPressed = false;
      bool goPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Numpad(
              onKeyPressed: (value) {
                keyPressed = value;
              },
              onClearPressed: () {
                clearPressed = true;
              },
              onGoPressed: () {
                goPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('1'));
      expect(keyPressed, '1');

      await tester.tap(find.text('C'));
      expect(clearPressed, true);

      await tester.tap(find.text('GO'));
      expect(goPressed, true);
    });
  });

  group('NumpadInput Widget', () {
    testWidgets('Renders input and Numpad correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NumpadInput(
              onKeyPressed: (value) {},
              onClearPressed: () {},
              onGoPressed: (value) {},
            ),
          ),
        ),
      );

      expect(find.text('0'), findsOneWidget); // Assuming 0 is part of Numpad
      expect(find.text('C'),
          findsOneWidget); // Assuming C (Clear) is part of Numpad
      expect(find.text('GO'), findsOneWidget); // Assuming GO is part of Numpad
      expect(find.text(''), findsOneWidget); // Empty input field initially
    });

    testWidgets('Input updates correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NumpadInput(
              onKeyPressed: (value) {},
              onClearPressed: () {},
              onGoPressed: (value) {},
            ),
          ),
        ),
      );

      Finder inputField = find.byKey(const Key('numpad_input_text'));

      // Tap buttons to simulate user input
      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      // Verify 1 is in the input field
      expect((tester.widget(inputField) as Text).data, '1');
    });

    testWidgets('Clear button clears input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NumpadInput(
              onKeyPressed: (value) {},
              onClearPressed: () {},
              onGoPressed: (value) {},
            ),
          ),
        ),
      );

      Finder inputField = find.byKey(const Key('numpad_input_text'));

      // Tap a button to simulate user input
      await tester.tap(find.text('1'));
      await tester.pump();

      // Tap clear button
      await tester.tap(find.text('C'));
      await tester.pump();

      // Verify input field is empty
      expect((tester.widget(inputField) as Text).data, '');
    });

    testWidgets('Go button triggers correct callback',
        (WidgetTester tester) async {
      String goPressedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NumpadInput(
              onKeyPressed: (value) {},
              onClearPressed: () {},
              onGoPressed: (value) {
                goPressedValue = value;
              },
            ),
          ),
        ),
      );

      // Tap buttons to simulate user input
      await tester.tap(find.text('1'));
      await tester.pump();
      await tester.tap(find.text('2'));
      await tester.pump();

      // Tap GO button
      await tester.tap(find.text('GO'));
      await tester.pump();

      expect(goPressedValue,
          '12'); // Verify that onGoPressed callback is called with correct value
    });
  });
}
