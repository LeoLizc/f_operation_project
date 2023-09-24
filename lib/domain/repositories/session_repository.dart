import 'package:f_operation_project/domain/models/session.dart';

abstract class SessionRepository {
  Future<GameSession> getSession({String id, String username});
  Future<bool> addSession(GameSession session);
  // Future<bool> updateSession(GameSession session);
  Future<bool> deleteSession(GameSession session);
  Future<List<GameSession>> getSessions();
}
