import 'package:f_operation_project/ui/controllers/auth_controller.dart';
import 'package:f_operation_project/ui/pages/authentication/registro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class MoclAuthController extends GetxController
    with Mock
    implements AuthController {}

void main() {
  late AuthController fakeAuthController;

  setUp(() {
    fakeAuthController = MoclAuthController();
    // Reemplazamos el AuthController original con el FakeAuthController
    Get.put<AuthController>(fakeAuthController);
  });

  testWidgets('Registro form validation', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: Registro()));

    // Introducimos valores inválidos en algunos campos
    await tester.enterText(find.byKey(const ValueKey("UsuarioRegistro")), "");
    await tester.enterText(find.byKey(const ValueKey("Nombre")), "");
    await tester.enterText(find.byKey(const ValueKey("Apellido")), "");
    await tester.enterText(find.byKey(const ValueKey("Grado")), "");
    await tester.enterText(find.byKey(const ValueKey("Colegio")), "");
    await tester.enterText(find.byKey(const ValueKey("Dia")), "");
    await tester.enterText(find.byKey(const ValueKey("Mes")), "");
    await tester.enterText(find.byKey(const ValueKey("Año")), "");
    await tester.enterText(find.byKey(const ValueKey("Contraseña1")), "");
    await tester.enterText(find.byKey(const ValueKey("Contraseña2")), "");

    // Intentamos realizar el registro
    await tester.tap(find.byKey(const ValueKey("Registrar")));
    await tester.pump();

    // Verificamos si los mensajes de error se muestran correctamente
    expect(find.text("Por favor ingrese su usuario"), findsOneWidget);
    expect(find.text("Por favor ingrese su nombre"), findsOneWidget);
    expect(find.text("Por favor ingrese su apellido"), findsOneWidget);
    expect(find.text("Por favor ingrese el grado que cursa"), findsOneWidget);
    expect(find.text("Por favor ingrese su colegio"), findsOneWidget);
    expect(find.text("Por favor ingrese el dia"), findsOneWidget);
    expect(find.text("Por favor ingrese el mes"), findsOneWidget);
    expect(find.text("Por favor ingrese el año"), findsOneWidget);
    expect(find.text("Por favor ingrese su contraseña"), findsOneWidget);
    expect(find.text("Las contraseñas no coinciden"), findsOneWidget);
  });

  testWidgets('Registro form submission', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home: Registro()));

    // Introducimos valores válidos en los campos
    await tester.enterText(
        find.byKey(const ValueKey("UsuarioRegistro")), "username");
    await tester.enterText(find.byKey(const ValueKey("Nombre")), "John");
    await tester.enterText(find.byKey(const ValueKey("Apellido")), "Doe");
    await tester.enterText(find.byKey(const ValueKey("Grado")), "12");
    await tester.enterText(
        find.byKey(const ValueKey("Colegio")), "High School");
    await tester.enterText(find.byKey(const ValueKey("Dia")), "01");
    await tester.enterText(find.byKey(const ValueKey("Mes")), "01");
    await tester.enterText(find.byKey(const ValueKey("Año")), "2000");
    await tester.enterText(
        find.byKey(const ValueKey("Contraseña1")), "password");
    await tester.enterText(
        find.byKey(const ValueKey("Contraseña2")), "password");

    // Mock de la función register en FakeAuthController
    when(() => fakeAuthController.register(
          birthDay: any(named: "birthDay"),
          birthMonth: any(named: "birthMonth"),
          birthYear: any(named: "birthYear"),
          grade: any(named: "grade"),
          school: any(named: "school"),
          username: any(named: "username"),
          password: any(named: "password"),
          firstName: any(named: "firstName"),
          lastName: any(named: "lastName"),
        )).thenAnswer((_) async => true);

    // Intentamos realizar el registro
    await tester.tap(find.byKey(const ValueKey("Registrar")));
    await tester.pump();

    // Verificamos si se llamó a la función register en FakeAuthController
    verify(() => fakeAuthController.register(
          birthDay: 1,
          birthMonth: 1,
          birthYear: 2000,
          grade: 12,
          school: "High School",
          username: "username",
          password: "password",
          firstName: "John",
          lastName: "Doe",
        )).called(1);
  });
}
