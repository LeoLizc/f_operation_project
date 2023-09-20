import 'package:f_operation_project/domain/models/operation.dart';

class GameUseCase {
  List<Operation> startGame() {
    List<Operation> operations = [];
    for (int i = 0; i < 6; i++) {
      Operation operation =
          Operation(operando1: 1, operando2: 2, operador: "+", resultado: 3);
      operations.add(operation);
    }
    return operations;
  }
}
