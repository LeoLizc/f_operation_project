import 'package:f_operation_project/domain/models/session.dart';
import 'package:hive/hive.dart';

class HiveSessionDataSource {
  Future<GameSession> getSession({int? id, String? username}) async {
    final box = await Hive.openBox('Dato_db_session');
    final session = box.values.firstWhere(
        (element) => element.id == id || element.username == username);
    await box.close();

    return GameSession(
      id: session.id,
      username: session.username,
      difficultyLevel: session.difficultyLevel,
      score: session.score,
      tSeconds: session.tSeconds,
    );
  }

  Future<List<GameSession>> getSessions() async {
    final box = await Hive.openBox('Dato_db_session');
    final sessions = box.values
        .map((e) => GameSession(
              id: e.id,
              username: e.username,
              difficultyLevel: e.difficultyLevel,
              score: e.score,
              tSeconds: e.tSeconds,
            ))
        .toList();
    await box.close();

    return sessions;
  }

  Future<GameSession> updateSession(GameSession session) async {
    final box = await Hive.openBox('Dato_db_session');
    final sessionToUpdate =
        box.values.firstWhere((element) => element.id == session.id);
    sessionToUpdate.score = session.score;
    sessionToUpdate.tSeconds = session.tSeconds;
    sessionToUpdate.difficultyLevel = session.difficultyLevel;
    sessionToUpdate.username = session.username;
    box.put(sessionToUpdate.key, sessionToUpdate);

    await box.close();

    return GameSession(
      id: sessionToUpdate.id,
      username: sessionToUpdate.username,
      difficultyLevel: sessionToUpdate.difficultyLevel,
      score: sessionToUpdate.score,
      tSeconds: sessionToUpdate.tSeconds,
    );
  }

  Future<bool> createSession(GameSession session) async {
    final box = await Hive.openBox('Dato_db_session');
    final sessionToCreate = GameSession(
      id: session.id,
      username: session.username,
      difficultyLevel: session.difficultyLevel,
      score: session.score,
      tSeconds: session.tSeconds,
    );
    box.add(sessionToCreate);

    await box.close();

    return true;
  }

  Future<bool> deleteSession(GameSession session) async {
    final box = await Hive.openBox('Dato_db_session');
    final sessionToDelete =
        box.values.firstWhere((element) => element.id == session.id);
    if (sessionToDelete != null) {
      box.delete(sessionToDelete.key);

      await box.close();

      return true;
    } else {
      await box.close();
      return false;
    }
  }

  Future<bool> deleteAllSessions() async {
    final box = await Hive.openBox('Dato_db_session');
    box.clear();
    await box.close();

    return true;
  }
}
