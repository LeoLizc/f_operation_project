import 'package:flutter_test/flutter_test.dart';
import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/models/user.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';
import 'package:f_operation_project/domain/repositories/auth_repositoy.dart';
import 'package:f_operation_project/domain/use_cases/authentication_usecase.dart';
import 'package:get/get.dart';

class MockAuthRepository extends Fake implements AuthRepository {
  @override
  Future<bool> login(LoginModel loginModel) async {
    // Simular lógica de autenticación
    return true;
  }

  @override
  Future<bool> logout() async {
    // Simular lógica de cierre de sesión
    return true;
  }

  @override
  Future<bool> register(Auth authInformation) async {
    // Simular lógica de registro
    return true;
  }
}

class MockUserRepository extends Fake implements UserRepository {
  @override
  Future<bool> addUser(User userInformation) async {
    // Simular lógica de agregar usuario
    return true;
  }
}

void main() {
  group('AuthenticationUseCase', () {
    test('login should return true on successful login', () async {
      final authRepository = MockAuthRepository();
      final userRepository = MockUserRepository();

      final authenticationUseCase = AuthenticationUseCase(
          authRepository: authRepository, userRepository: userRepository);

      final result = await authenticationUseCase.login('username', 'password');
      expect(result, true);
    });

    test('logout should return true on successful logout', () async {
      final authRepository = MockAuthRepository();
      final userRepository = MockUserRepository();

      final authenticationUseCase = AuthenticationUseCase(
          authRepository: authRepository, userRepository: userRepository);

      final result = await authenticationUseCase.logout();
      expect(result, true);
    });

    test('register should return true on successful registration', () async {
      final authRepository = MockAuthRepository();
      final userRepository = MockUserRepository();

      final authenticationUseCase = AuthenticationUseCase(
          authRepository: authRepository, userRepository: userRepository);

      final result = await authenticationUseCase.register(RegisterModel(
          username: 'username',
          password: 'password',
          firstName: 'John',
          lastName: 'Doe',
          birthDate: '01/01/2000',
          grade: 5,
          school: 'Estrellitas del mañana'));
      expect(result, true);
    });
  });
}
