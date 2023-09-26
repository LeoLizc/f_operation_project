import 'package:f_operation_project/domain/models/operation.dart';
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
    _currentOperationIndex.value = 0;
    _score = 0;

    _operations.assignAll(_gameUseCase.startGame(level));
  }

  bool answer(int answer) {
    if (operation != null && _gameUseCase.checkAnswer(operation!, answer)) {
      _score++;
    }

    if (operationIndex >= _operations.length) {
      return true;
    }

    _currentOperationIndex.value++;
    return false;
  }
}
