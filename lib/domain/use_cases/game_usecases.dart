import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/models/operation.dart';
import 'package:f_operation_project/domain/models/session.dart';
import 'package:f_operation_project/domain/repositories/auth_repositoy.dart';
import 'package:f_operation_project/domain/repositories/session_repository.dart';
import 'package:get/get.dart';

class GameUseCase {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final SessionRepository _sessionRepository = Get.find<SessionRepository>();

  List<Operation> startGame(int difficultyLevel) {
    List<Operation> operations = [];
    for (int i = 0; i < 6; i++) {
      Operation operation = Operation(
          operando1: (i + 1),
          operando2: (i + 1) * 2 - 1,
          operador: "+",
          resultado: (i + 1) * 3 - 1);
      operations.add(operation);
    }
    return operations;
  }

  bool checkAnswer(Operation operation, int answer) {
    return operation.resultado == answer;
  }

  Future<void> cambiarDificultad(GameSession session) async {
    if (session.score >= 3 && session.score < 5 ||
        session.tSeconds > 120 && session.tSeconds <= 300) {
      return;
    }

    if (session.score > 5 && session.tSeconds <= 120) {
      session.difficultyLevel += 1;
    } else if (session.score < 3 && session.tSeconds > 300) {
      session.difficultyLevel -= 1;
    }

    Auth me = (await _authRepository.me())!;
    session.username = me.username;

    // Save session
    await _sessionRepository.addSession(session);
  }
}
