import 'package:f_operation_project/domain/models/operation.dart';
import 'package:f_operation_project/domain/models/session.dart';
import 'package:f_operation_project/domain/use_cases/game_usecases.dart';
import 'package:f_operation_project/ui/controllers/game_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGameUseCase extends Mock implements GameUseCase {}

class FakeOperation extends Fake implements Operation {}

class FakeGameSession extends Fake implements GameSession {}

Matcher customSessionMatcher(
    {String? username, int? score, int? tSeconds, int? difficultyLevel}) {
  return predicate((actual) {
    if (actual is! GameSession) {
      return false;
    }
    final session = actual; // as GameSession;//* Dart says is unnecessary
    return (username == null || session.username == username) &&
        (score == null || session.score == score) &&
        (tSeconds == null || session.tSeconds == tSeconds) &&
        (difficultyLevel == null || session.difficultyLevel == difficultyLevel);
  }, 'is a GameSession with username=$username, score=$score, tSeconds=$tSeconds, difficultyLevel=$difficultyLevel');
}

void main() {
  late GameController gameController;
  late MockGameUseCase mockGameUseCase;

  setUp(() {
    mockGameUseCase = MockGameUseCase();
    gameController = GameController(mockGameUseCase);
  });

  setUpAll(() {
    registerFallbackValue(FakeOperation());
    registerFallbackValue(FakeGameSession());
  });

  group("GameController", () {
    test('startGame sets level and operations correctly', () async {
      // Arrange
      const level = 2;
      final operations = [
        Operation(operando1: 3, operador: '+', operando2: 4, resultado: 7),
        Operation(operando1: 5, operador: '-', operando2: 2, resultado: 3),
      ];

      when(() => mockGameUseCase.getDifficultyLevel())
          .thenAnswer((_) async => level);
      when(() => mockGameUseCase.startGame(level)).thenReturn(operations);

      // Act
      await gameController.startGame();

      // Assert
      expect(gameController.level, level);
      expect(gameController.score, 0);
      expect(gameController.operationIndex, 0);
      expect(gameController.operation, operations[0]);
    });

    test('answer updates score and operation index correctly', () async {
      // Arrange
      const level = 2;
      final operations = [
        Operation(operando1: 3, operador: '+', operando2: 4, resultado: 7),
        Operation(operando1: 5, operador: '-', operando2: 2, resultado: 3),
      ];

      when(() => mockGameUseCase.getDifficultyLevel())
          .thenAnswer((_) async => level);
      when(() => mockGameUseCase.startGame(level)).thenReturn(operations);

      gameController.level = level;
      gameController.startGame();
      // gameController.operationIndex = 0;

      when(() => mockGameUseCase.checkAnswer(any(), any())).thenReturn(true);

      // Act
      final result = await gameController.answer(7);

      // Assert
      expect(gameController.score, 1);
      expect(gameController.operationIndex, 1);
      expect(result, false);
    });

    test(
        'answer updates level, score, and restarts game when operations are completed',
        () async {
      // Arrange
      const level = 2;
      final operations = [
        Operation(operando1: 3, operador: '+', operando2: 4, resultado: 7),
        Operation(operando1: 5, operador: '-', operando2: 2, resultado: 3),
      ];

      when(() => mockGameUseCase.getDifficultyLevel())
          .thenAnswer((_) async => level);
      when(() => mockGameUseCase.startGame(any())).thenReturn(operations);
      when(() => mockGameUseCase.checkAnswer(any(), any())).thenReturn(true);
      when(() => mockGameUseCase.cambiarDificultad(any()))
          .thenAnswer((_) async => level + 1);

      gameController.level = level;
      await gameController.startGame();
      await gameController.answer(7);
      // gameController.operationIndex = 1;

      expect(gameController.score, 1);
      when(() => mockGameUseCase.checkAnswer(any(), any())).thenReturn(true);
      when(() => mockGameUseCase.cambiarDificultad(any()))
          .thenAnswer((_) async => level + 1);

      // Act
      final result = await gameController.answer(3);

      // Assert
      expect(
          verify(() => mockGameUseCase.cambiarDificultad(captureAny()))
              .captured
              .last,
          customSessionMatcher(score: 2));
      expect(gameController.operationIndex, 0);
      expect(gameController.level, level + 1);
      expect(result, true);
    });
  });
}
