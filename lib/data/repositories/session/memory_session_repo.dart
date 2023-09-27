import 'package:f_operation_project/domain/models/session.dart';
import 'package:f_operation_project/domain/repositories/session_repository.dart';

class MemorySessionRepository implements SessionRepository {
  int _id = 0;
  final _sessions = <GameSession>[];

  @override
  Future<bool> addSession(GameSession session) {
    _id++;
    _sessions.add(GameSession(
      id: _id,
      username: session.username,
      score: session.score,
      tSeconds: session.tSeconds,
      difficultyLevel: session.difficultyLevel,
    ));
    return Future.value(true);
  }

  @override
  Future<bool> deleteSession(GameSession session) {
    _sessions.remove(session);
    return Future.value(true);
  }

  @override
  Future<GameSession> getSession({int? id, String? username}) {
    return Future.value(_sessions.firstWhere(
        (session) => session.id == id! || session.username == username));
  }

  @override
  Future<List<GameSession>> getSessions() {
    return Future.value(_sessions);
  }
}
