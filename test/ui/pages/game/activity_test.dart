import 'package:f_operation_project/domain/models/operation.dart';
import 'package:f_operation_project/ui/controllers/game_controller.dart';
import 'package:f_operation_project/ui/pages/game/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

// Importamos nuestra FakeGameController
class MockGameController extends GetxController
    with Mock
    implements GameController {}

void main() {
  late GameController fakeGameController;

  setUp(() {
    fakeGameController = MockGameController();
    // Reemplazamos el GameController original con el FakeGameController
    Get.put<GameController>(fakeGameController);
  });

  testWidgets('Activity Page displays loading message',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: ActivityPage()));

    // Verificamos si el texto de carga se muestra correctamente
    expect(find.text('Cargando operaciones...'), findsOneWidget);
  });

  testWidgets('Activity Page displays operation', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home: ActivityPage()));

    // Verificamos si la operación se muestra correctamente
    expect(find.text('10 + 5 = ?'), findsOneWidget);
  });

  testWidgets('Answer is passed to GameController',
      (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home: ActivityPage()));

    // Mock de GameController
    when(() => fakeGameController.operation).thenReturn(
      Operation(operando1: 10, operando2: 5, operador: '+', resultado: 15),
    );

    // Introducimos una respuesta en el NumpadInput
    await tester.enterText(find.byKey(const ValueKey("NumpadInput")), "15");

    // Simulamos el press del botón "GO"
    await tester.tap(find.text('Iniciar seccion'));
    await tester.pump();

    // Verificamos si el GameController recibe la respuesta correctamente
    verify(() => fakeGameController.answer(15)).called(1);
  });
}
