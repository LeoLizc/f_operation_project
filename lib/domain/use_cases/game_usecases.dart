import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/models/operation.dart';
import 'package:f_operation_project/domain/models/session.dart';
import 'package:f_operation_project/domain/models/user.dart';
import 'package:f_operation_project/domain/repositories/auth_repositoy.dart';
import 'package:f_operation_project/domain/repositories/session_repository.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';
import 'package:get/get.dart';

class GameUseCase {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final SessionRepository _sessionRepository = Get.find<SessionRepository>();
  final UserRepository _userRepository = Get.find<UserRepository>();

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

  Future<int> cambiarDificultad(GameSession session) async {
    int newDifficultyLevel = session.difficultyLevel;

    if (session.score > 5 && session.tSeconds <= 120) {
      newDifficultyLevel = session.difficultyLevel + 1;
    } else if (session.score < 3 && session.tSeconds > 300) {
      newDifficultyLevel = session.difficultyLevel - 1;
    }

    Future(() async {
      Auth me = (await _authRepository.me())!;
      session.username = me.username;

      if (newDifficultyLevel != session.difficultyLevel) {
        // Get the user
        User user = await _userRepository.getUser(username: me.username);
        // Update and save the user
        user.difficultyLevel = newDifficultyLevel;
        _userRepository.updateUser(user);
      }

      // Save session
      _sessionRepository.addSession(session);
    });
    return newDifficultyLevel;
  }

  Future<int> getDifficultyLevel() async {
    Auth me = (await _authRepository.me())!;
    User user = await _userRepository.getUser(username: me.username);
    return user.difficultyLevel;
  }
}
