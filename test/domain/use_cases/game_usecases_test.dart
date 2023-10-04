import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/models/operation.dart';
import 'package:f_operation_project/domain/models/session.dart';
import 'package:f_operation_project/domain/models/user.dart';
import 'package:f_operation_project/domain/repositories/auth_repositoy.dart';
import 'package:f_operation_project/domain/repositories/session_repository.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:f_operation_project/domain/use_cases/game_usecases.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSessionRepository extends Mock implements SessionRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class FakeUser extends Fake implements User {
  @override
  int difficultyLevel;

  FakeUser({required this.difficultyLevel});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FakeUser &&
          runtimeType == other.runtimeType &&
          difficultyLevel == other.difficultyLevel;

  @override
  int get hashCode => difficultyLevel.hashCode;
}

Matcher isOperationWith(
    {required int operando1,
    required int operando2,
    required String operador,
    required int resultado}) {
  return predicate((actual) {
    if (actual is! Operation) {
      return false;
    }
    final operation = actual; // as Operation; //* Dart says is unnecessary
    return operation.operando1 == operando1 &&
        operation.operando2 == operando2 &&
        operation.operador == operador &&
        operation.resultado == resultado;
  }, 'is an Operation with operando1=$operando1, operando2=$operando2, operador=$operador, resultado=$resultado');
}

Matcher isGameSessionWith(
    {required String username,
    required int score,
    required int tSeconds,
    required int difficultyLevel}) {
  return predicate((actual) {
    if (actual is! GameSession) {
      return false;
    }
    final session = actual; // as GameSession; //* Dart says is unnecessary
    return session.username == username &&
        session.score == score &&
        session.tSeconds == tSeconds &&
        session.difficultyLevel == difficultyLevel;
  }, 'is a GameSession with username=$username, score=$score, tSeconds=$tSeconds, difficultyLevel=$difficultyLevel');
}

void main() {
  group('GameUseCase', () {
    late MockAuthRepository authRepository;
    late MockSessionRepository sessionRepository;
    late MockUserRepository userRepository;
    late GameUseCase gameUseCase;

    setUp(() {
      authRepository = MockAuthRepository();
      sessionRepository = MockSessionRepository();
      userRepository = MockUserRepository();
      gameUseCase = GameUseCase(
        authRepository: authRepository,
        sessionRepository: sessionRepository,
        userRepository: userRepository,
      );
    });

    setUpAll(() {
      registerFallbackValue(Auth(
        username: 'testuser',
        firstName: 'pepito',
        lastName: 'perez',
      ));
      registerFallbackValue(FakeUser(
        difficultyLevel: 2,
      ));

      registerFallbackValue(GameSession(
        username: 'testuser',
        score: 6,
        tSeconds: 100,
        difficultyLevel: 2,
      ));

      registerFallbackValue(Operation(
        operando1: 2,
        operando2: 3,
        operador: '+',
        resultado: 5,
      ));

      registerFallbackValue(LoginModel(
        username: 'testuser',
        password: 'testpassword',
      ));
    });

    group('startGame', () {
      test('returns a list of 6 operations', () {
        final operations = gameUseCase.startGame(1);
        expect(operations, hasLength(6));
        // expect(operations.every((op) => op is Operation), isTrue); //* Dart says is unnecessary
      });
    });

    group('checkAnswer', () {
      test('returns true if the answer is correct', () {
        final operation = Operation(
          operando1: 2,
          operando2: 3,
          operador: '+',
          resultado: 5,
        );
        final result = gameUseCase.checkAnswer(operation, 5);
        expect(result, isTrue);
      });

      test('returns false if the answer is incorrect', () {
        final operation = Operation(
          operando1: 2,
          operando2: 3,
          operador: '+',
          resultado: 5,
        );
        final result = gameUseCase.checkAnswer(operation, 6);
        expect(result, isFalse);
      });
    });

    group('cambiarDificultad', () {
      test('returns the same difficulty level if no change is needed',
          () async {
        final session = GameSession(
          username: 'testuser',
          score: 3,
          tSeconds: 100,
          difficultyLevel: 2,
        );
        when(() => authRepository.me()).thenAnswer((_) async => Auth(
              username: 'testuser',
              firstName: 'pepito',
              lastName: 'perez',
            ));

        when(() => userRepository.getUser(username: 'testuser'))
            .thenAnswer((_) async => FakeUser(difficultyLevel: 2));

        when(() => sessionRepository.addSession(any())).thenAnswer((_) async {
          return true;
        });

        final result = await gameUseCase.cambiarDificultad(session);
        expect(result, equals(2));
        verifyNever(() => userRepository.updateUser(any()));
        verify(() => sessionRepository.addSession(any())).called(1);
      });

      test('returns a higher difficulty level if score is high and time is low',
          () async {
        final session = GameSession(
          username: 'testuser',
          score: 6,
          tSeconds: 100,
          difficultyLevel: 2,
        );

        when(() => authRepository.me()).thenAnswer((_) async => Auth(
              username: 'testuser',
              firstName: 'pepito',
              lastName: 'perez',
            ));

        when(() => userRepository.getUser(username: 'testuser'))
            .thenAnswer((_) async => FakeUser(difficultyLevel: 2));

        when(() => userRepository.updateUser(any())).thenAnswer((_) async {
          return FakeUser(difficultyLevel: 3);
        });

        when(() => sessionRepository.addSession(any())).thenAnswer((_) async {
          return true;
        });

        final result = await gameUseCase.cambiarDificultad(session);
        expect(result, equals(3));
        verify(() => userRepository.updateUser(FakeUser(difficultyLevel: 3)))
            .called(1);
        verify(() => sessionRepository.addSession(session)).called(1);
      });

      test('returns a lower difficulty level if score is low and time is high',
          () async {
        final session = GameSession(
          username: 'testuser',
          score: 2,
          tSeconds: 400,
          difficultyLevel: 3,
        );
        when(() => authRepository.me()).thenAnswer((_) async => Auth(
              username: 'testuser',
              firstName: 'pepito',
              lastName: 'perez',
            ));

        when(() => userRepository.getUser(username: 'testuser'))
            .thenAnswer((_) async => FakeUser(difficultyLevel: 2));

        when(() => userRepository.updateUser(any())).thenAnswer((_) async {
          return FakeUser(difficultyLevel: 3);
        });

        when(() => sessionRepository.addSession(any())).thenAnswer((_) async {
          return true;
        });

        final result = await gameUseCase.cambiarDificultad(session);
        expect(result, equals(2));
        verify(() => userRepository.updateUser(FakeUser(difficultyLevel: 2)))
            .called(1);
        verify(() => sessionRepository.addSession(session)).called(1);
      });
    });

    group('getDifficultyLevel', () {
      test('returns the user difficulty level', () async {
        when(() => authRepository.me()).thenAnswer((_) async => Auth(
              username: 'testuser',
              firstName: 'pepito',
              lastName: 'perez',
            ));
        when(() => userRepository.getUser(username: 'testuser'))
            .thenAnswer((_) async => FakeUser(difficultyLevel: 2));
        final result = await gameUseCase.getDifficultyLevel();
        expect(result, equals(2));
      });
    });
  });
}
