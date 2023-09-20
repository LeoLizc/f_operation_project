import 'package:f_operation_project/domain/models/operation.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  final RxList<Operation> _operations = <Operation>[
    Operation(operando1: 1, operando2: 1, operador: '+', resultado: 2),
    Operation(operando1: 1, operando2: 2, operador: '+', resultado: 3),
    Operation(operando1: 2, operando2: 1, operador: '+', resultado: 3),
    Operation(operando1: 2, operando2: 2, operador: '+', resultado: 4),
    Operation(operando1: 3, operando2: 1, operador: '+', resultado: 4),
    Operation(operando1: 3, operando2: 2, operador: '+', resultado: 5),
  ].obs;
  final RxInt _currentOperationIndex = 0.obs;
  int _score = 0;

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
    // TODO: HERE USE THE USECASES
    _operations.assignAll([
      Operation(operando1: 1, operando2: 1, operador: '+', resultado: 2),
      Operation(operando1: 1, operando2: 2, operador: '+', resultado: 3),
      Operation(operando1: 2, operando2: 1, operador: '+', resultado: 3),
      Operation(operando1: 2, operando2: 2, operador: '+', resultado: 4),
      Operation(operando1: 3, operando2: 1, operador: '+', resultado: 4),
      Operation(operando1: 3, operando2: 2, operador: '+', resultado: 5),
    ]);
  }

  bool answer(int answer) {
    if (operation != null && operation?.resultado == answer) {
      _score++;
    }

    if (operationIndex >= _operations.length) {
      return true;
    }

    _currentOperationIndex.value++;
    return false;
  }
}
