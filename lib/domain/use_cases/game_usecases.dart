import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/models/operation.dart';
import 'package:f_operation_project/domain/models/session.dart';
import 'package:f_operation_project/domain/models/user.dart';
import 'package:f_operation_project/domain/repositories/auth_repositoy.dart';
import 'package:f_operation_project/domain/repositories/session_repository.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'dart:math';

class GameUseCase {
  final AuthRepository _authRepository;
  final SessionRepository _sessionRepository;
  final UserRepository _userRepository;

  GameUseCase(
      {required AuthRepository authRepository,
      required SessionRepository sessionRepository,
      required UserRepository userRepository})
      : _authRepository = authRepository,
        _sessionRepository = sessionRepository,
        _userRepository = userRepository;

  List<Operation> startGame(int difficultyLevel) {
    List<Operation> operations = [];
    for (int i = 0; i < 6; i++) {
      operations.add(_createOperation(difficultyLevel));
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

Operation _createOperation(int level) {
  var rng = Random();
  int uno, dos;

  switch (level) {
    case 1:
      uno = rng.nextInt(max(1, 10));
      dos = rng.nextInt(max(1, 10));
      return Operation(
          operando1: uno, operando2: dos, operador: "+", resultado: uno + dos);

    case 2:
      uno = rng.nextInt(max(1, 100));
      dos = rng.nextInt(max(1, 100));
      return Operation(
          operando1: uno, operando2: dos, operador: "+", resultado: uno + dos);

    case 3:
      if (rng.nextInt(3) == 1) {
        uno = rng.nextInt(max(1, 100));
        dos = rng.nextInt(max(1, 100));
        return Operation(
            operando1: uno,
            operando2: dos,
            operador: "+",
            resultado: uno + dos);
      } else {
        uno = rng.nextInt(max(1, 10));
        dos = rng.nextInt(max(1, 10));
        return Operation(
            operando1: uno,
            operando2: dos,
            operador: "*",
            resultado: uno * dos);
      }

    case 4:
      if (rng.nextInt(3) == 1) {
        uno = rng.nextInt(max(100, 1000));
        dos = rng.nextInt(max(100, 1000));
        return Operation(
            operando1: uno,
            operando2: dos,
            operador: "+",
            resultado: uno + dos);
      } else {
        uno = rng.nextInt(max(10, 100));
        dos = rng.nextInt(max(1, 10));
        return Operation(
            operando1: uno,
            operando2: dos,
            operador: "*",
            resultado: uno * dos);
      }

    case 5:
      if (rng.nextInt(3) == 1) {
        uno = rng.nextInt(max(1000, 10000));
        dos = rng.nextInt(max(100, 1000));
        return Operation(
            operando1: uno,
            operando2: dos,
            operador: "+",
            resultado: uno + dos);
      } else {
        uno = rng.nextInt(max(10, 100));
        dos = rng.nextInt(max(10, 100));
        return Operation(
            operando1: uno,
            operando2: dos,
            operador: "*",
            resultado: uno * dos);
      }

    default:
      return Operation(
          operando1: 1,
          operando2: 2,
          operador: "Esto es físicamente imposible",
          resultado: 1 * 1);
  }
}
