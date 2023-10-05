import 'package:f_operation_project/ui/controllers/auth_controller.dart';
import 'package:f_operation_project/ui/pages/authentication/login.dart';
import 'package:f_operation_project/ui/pages/authentication/registro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class FakeAuthController extends GetxController
    with Fake
    implements AuthController {
  @override
  Future<bool> login(String username, String password) async {
    // Simulamos una autenticación exitosa
    return true;
  }
}

class MockAuthController extends GetxController
    with Mock
    implements AuthController {}

void main() {
  late AuthController fakeAuthController;

  setUp(() {
    fakeAuthController = MockAuthController();
    // Reemplazamos el AuthController original con el FakeAuthController
    Get.put<AuthController>(fakeAuthController);
  });

  testWidgets('Login form validation', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: Login()));

    when(() => fakeAuthController.login(any(), any()))
        .thenAnswer((_) async => true);

    // Introducimos un nombre de usuario y contraseña inválidos
    await tester.enterText(find.byKey(const ValueKey("Usuario")), "");
    await tester.enterText(find.byKey(const ValueKey("Contraseña")), "");

    // Intentamos iniciar sesión
    await tester.tap(find.byKey(const ValueKey("Iniciar")));
    await tester.pump();

    // Verificamos si los mensajes de error se muestran correctamente
    expect(find.text("Por favor ingrese su usuario"), findsOneWidget);
    expect(find.text("Por favor ingrese su contraseña"), findsOneWidget);
  });

  testWidgets('Login form submission', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: Login()));

    // Introducimos un nombre de usuario y contraseña válidos
    await tester.enterText(find.byKey(const ValueKey("Usuario")), "username");
    await tester.enterText(
        find.byKey(const ValueKey("Contraseña")), "password1234");

    // Mock de la función login en FakeAuthController
    when(() => fakeAuthController.login("username", "password1234"))
        .thenAnswer((_) async => true);

    // Intentamos iniciar sesión
    await tester.tap(find.byKey(const ValueKey("Iniciar")));
    await tester.pump();

    // Verificamos si se llamó a la función login en FakeAuthController
    verify(() => fakeAuthController.login("username", "password1234"))
        .called(1);
  });

  testWidgets('Navigation to registration screen', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => const Login(
                  key: Key('Login'),
                )),
        GetPage(
            name: '/register',
            page: () => const Registro(
                  key: ValueKey('Registro'),
                )),
      ],
    ));

    // Tocamos el botón de registro
    await tester.tap(find.byKey(const ValueKey("Registrarse")));
    await tester.pumpAndSettle();

    // Verificamos si se navegó a la pantalla de registro
    expect(find.byType(Login), findsNothing);
    expect(find.byKey(const ValueKey("Registro")), findsOneWidget);
  });
}
