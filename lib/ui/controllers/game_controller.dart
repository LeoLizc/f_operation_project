import 'package:f_operation_project/domain/models/operation.dart';
import 'package:f_operation_project/domain/models/session.dart';
import 'package:f_operation_project/domain/use_cases/game_usecases.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  final GameUseCase _gameUseCase = Get.find<GameUseCase>();

  final RxList<Operation> _operations = <Operation>[].obs;
  final RxInt _currentOperationIndex = 0.obs;
  int _score = 0;
  int level = 1;

  Operation? get operation {
    if (_currentOperationIndex.value >= _operations.length) {
      return null;
    }
    return _operations[_currentOperationIndex.value];
  }

  get score => _score;
  get operationIndex => _currentOperationIndex.value;

  void startGame() {
    _operations.clear();
    _score = 0;

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
          score: _score,
          tSeconds: 0,
          difficultyLevel: level,
        ),
      );
      startGame();
      // print(_currentOperationIndex.value);
      // print(_operations.length);
      return true;
    }

    return false;
  }
}
