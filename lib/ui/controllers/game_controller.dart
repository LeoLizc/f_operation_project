import 'package:f_operation_project/domain/models/operation.dart';
import 'package:f_operation_project/domain/models/session.dart';
import 'package:f_operation_project/domain/use_cases/game_usecases.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  final GameUseCase _gameUseCase;

  GameController(this._gameUseCase);

  final RxList<Operation> _operations = <Operation>[].obs;
  final RxInt _currentOperationIndex = 0.obs;
  final RxInt _level = 0.obs;
  RxInt _score = 0.obs;
  int get level => _level.value;
  set level(int value) => _level.value = value;

  Operation? get operation {
    if (_currentOperationIndex.value >= _operations.length) {
      return null;
    }
    return _operations[_currentOperationIndex.value];
  }

  get score => _score.value;
  get operationIndex => _currentOperationIndex.value;

  Future<void> startGame() async {
    _operations.clear();
    _score.value = 0;

    if (level == 0) {
      level = await _gameUseCase.getDifficultyLevel();
    }

    _operations.assignAll(_gameUseCase.startGame(level));
    _currentOperationIndex.value = 0;
  }

  Future<bool> answer(int answer) async {
    if (operation != null && _gameUseCase.checkAnswer(operation!, answer)) {
      _score++;
    }
    _currentOperationIndex.value++;

    if (operationIndex >= _operations.length) {
      level = await _gameUseCase.cambiarDificultad(
        GameSession(
          score: score,
          tSeconds: 0,
          difficultyLevel: level,
        ),
      );
      // startGame();
      // print(_currentOperationIndex.value);
      // print(_operations.length);
      return true;
    }

    return false;
  }
}
