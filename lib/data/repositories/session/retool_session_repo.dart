import 'package:f_operation_project/data/datasources/retome/session_retool_ds.dart';
import 'package:f_operation_project/domain/models/session.dart';
import 'package:f_operation_project/domain/repositories/session_repository.dart';

class RetoolSessionRepository implements SessionRepository {
  final RetoolSessionDataSource _dataSource = RetoolSessionDataSource();

  @override
  Future<bool> addSession(GameSession session) {
    return _dataSource.createSession(session);
  }

  @override
  Future<bool> deleteSession(GameSession session) {
    return _dataSource.deleteSession(session);
  }

  @override
  Future<GameSession> getSession({int? id, String? username}) {
    return _dataSource.getSession(id: id, username: username);
  }

  @override
  Future<List<GameSession>> getSessions({String? username}) {
    return _dataSource.getSessions(username: username);
  }
}
