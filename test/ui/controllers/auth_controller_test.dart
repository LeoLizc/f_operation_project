import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/use_cases/authentication_usecase.dart';
import 'package:f_operation_project/ui/controllers/auth_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationUseCase extends Mock implements AuthenticationUseCase {}

class FakeRegisterModel extends Fake implements RegisterModel {}

void main() {
  group('AuthController', () {
    late AuthController authController;
    late MockAuthenticationUseCase mockAuthUseCase;

    setUp(() {
      mockAuthUseCase = MockAuthenticationUseCase();
      authController = AuthController(mockAuthUseCase);
    });

    setUpAll(() {
      registerFallbackValue(FakeRegisterModel());
    });

    test('login should set isAuthenticated to true when login succeeds',
        () async {
      // Arrange
      const username = 'testuser';
      const password = 'testpassword';
      when(() => mockAuthUseCase.login(username, password))
          .thenAnswer((_) async => true);

      // Act
      final result = await authController.login(username, password);

      // Assert
      expect(result, isTrue);
      expect(authController.isAuthenticated, isTrue);
    });

    test('login should set isAuthenticated to false when login fails',
        () async {
      // Arrange
      const username = 'testuser';
      const password = 'testpassword';
      when(() => mockAuthUseCase.login(username, password))
          .thenAnswer((_) async => false);

      // Act
      final result = await authController.login(username, password);

      // Assert
      expect(result, isFalse);
      expect(authController.isAuthenticated, isFalse);
    });

    test('logout should set isAuthenticated to false when logout succeeds',
        () async {
      // Arrange
      when(() => mockAuthUseCase.logout()).thenAnswer((_) async => true);

      const username = 'testuser';
      const password = 'testpassword';
      when(() => mockAuthUseCase.login(username, password))
          .thenAnswer((_) async => false);

      // Login
      await authController.login(username, password);

      // Act
      await authController.logout();

      // Assert
      expect(authController.isAuthenticated, isFalse);
    });

    test('logout should set isAuthenticated to true when logout fails',
        () async {
      // Arrange
      when(() => mockAuthUseCase.logout()).thenAnswer((_) async => false);
      const username = 'testuser';
      const password = 'testpassword';
      when(() => mockAuthUseCase.login(username, password))
          .thenAnswer((_) async => false);

      // Login
      await authController.login(username, password);

      // Act
      await authController.logout();

      // Assert
      expect(authController.isAuthenticated, isTrue);
    });

    test(
        'register should call register on the auth use case with correct parameters',
        () async {
      // Arrange
      const username = 'testuser';
      const password = 'testpassword';
      const firstName = 'Test';
      const lastName = 'User';
      const grade = 10;
      const school = 'Test School';
      const birthDay = 1;
      const birthMonth = 1;
      const birthYear = 2000;
      final expectedUser = RegisterModel(
        grade: grade,
        school: school,
        birthDate: DateTime(birthYear, birthMonth, birthDay).toString(),
        difficultyLevel: 1,
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      when(() => mockAuthUseCase.register(any())).thenAnswer((_) async => true);

      // Act
      final result = await authController.register(
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName,
        grade: grade,
        school: school,
        birthDay: birthDay,
        birthMonth: birthMonth,
        birthYear: birthYear,
      );

      // Assert
      expect(result, isTrue);
      verify(() => mockAuthUseCase.register(expectedUser)).called(1);
    });
  });
}
