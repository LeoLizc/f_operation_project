import 'package:f_operation_project/domain/models/session.dart';

abstract class SessionRepository {
  Future<GameSession> getSession({required int id});
  Future<bool> addSession(GameSession session);
  // Future<bool> updateSession(GameSession session);
  Future<bool> deleteSession(GameSession session);
  Future<List<GameSession>> getSessions({String? username});
}
