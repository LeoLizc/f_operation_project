import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/models/user.dart';
import 'package:f_operation_project/domain/repositories/auth_repositoy.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';
import 'package:f_operation_project/domain/use_cases/authentication_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late AuthenticationUseCase authenticationUseCase;
  late MockAuthRepository mockAuthRepository;
  late MockUserRepository mockUserRepository;

  setUpAll(() {
    registerFallbackValue(
      LoginModel(
        username: 'username',
        password: 'password',
      ),
    );

    registerFallbackValue(
      Auth(
          username: 'username',
          password: 'password',
          firstName: 'John',
          lastName: 'Doe'),
    );

    registerFallbackValue(
      User(
        username: 'username',
        birthDate: '01/01/2000',
        grade: 5,
        school: 'Estrellitas del Mañana',
        difficultyLevel: 1,
      ),
    );
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserRepository = MockUserRepository();
    authenticationUseCase = AuthenticationUseCase(
      authRepository: mockAuthRepository,
      userRepository: mockUserRepository,
    );
  });

  group('AuthenticationUseCase', () {
    test('login returns true when successful', () async {
      // Arrange
      when(() => mockAuthRepository.login(any())).thenAnswer((_) async => true);
      when(() => mockUserRepository.getUser(username: any(named: 'username')))
          .thenAnswer((invocation) async => User(
                username: 'username',
                birthDate: '01/01/2000',
                grade: 5,
                school: 'Estrellitas del Mañana',
                difficultyLevel: 1,
              ));

      // Act
      final result = await authenticationUseCase.login('username', 'password');

      // Assert
      expect(result, true);
      verify(() => mockAuthRepository.login(
            LoginModel(
              username: 'username',
              password: 'password',
            ),
          )).called(1);
    });

    test('login returns false when unsuccessful', () async {
      // Arrange
      when(() => mockAuthRepository.login(any()))
          .thenAnswer((_) async => false);

      // Act
      final result = await authenticationUseCase.login('username', 'password');

      // Assert
      expect(result, false);
      verify(() => mockAuthRepository.login(LoginModel(
            username: 'username',
            password: 'password',
          ))).called(1);
    });

    test('logout returns true', () async {
      // Arrange
      when(() => mockAuthRepository.logout()).thenAnswer((_) async => true);

      // Act
      final result = await authenticationUseCase.logout();

      // Assert
      expect(result, true);
      verify(() => mockAuthRepository.logout()).called(1);
    });

    test('register returns true when successful', () async {
      // Arrange
      when(() => mockAuthRepository.register(any()))
          .thenAnswer((_) async => true);
      when(() => mockUserRepository.addUser(any()))
          .thenAnswer((_) async => true);

      final userInfo = RegisterModel(
          username: 'username',
          password: 'password',
          firstName: 'John',
          lastName: 'Doe',
          birthDate: '01/01/2000',
          grade: 5,
          school: 'Estrellitas del Mañana');
      // Act
      final result = await authenticationUseCase.register(userInfo);

      // Assert
      expect(result, true);
      verify(() => mockAuthRepository.register(userInfo.authInformation))
          .called(1);
      verify(() => mockUserRepository.addUser(userInfo.userInformation))
          .called(1);
    });

    test('register returns false when unsuccessful', () async {
      // Arrange
      when(() => mockAuthRepository.register(any()))
          .thenAnswer((_) async => false);

      final userInfo = RegisterModel(
          username: 'username',
          password: 'password',
          firstName: 'John',
          lastName: 'Doe',
          birthDate: '01/01/2000',
          grade: 5,
          school: 'Estrellitas del Mañana');

      // Act
      final result = await authenticationUseCase.register(userInfo);

      // Assert
      expect(result, false);
      verify(() => mockAuthRepository.register(userInfo.authInformation))
          .called(1);
    });
  });
}
