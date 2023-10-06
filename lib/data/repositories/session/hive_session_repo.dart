import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:f_operation_project/data/datasources/Local/session_hive_ds.dart';
import 'package:f_operation_project/data/datasources/retome/session_retool_ds.dart';
import 'package:f_operation_project/domain/models/session.dart';
import 'package:f_operation_project/domain/repositories/session_repository.dart';
import 'package:flutter/material.dart';

class HiveSessionRepository implements SessionRepository {
  final RetoolSessionDataSource _dataSource = RetoolSessionDataSource();
  final HiveSessionDataSource _dataSourceH = HiveSessionDataSource();

  @override
  Future<bool> addSession(GameSession session) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool saved = await _dataSourceH.createSession(session);

    if (!saved) {
      throw ErrorDescription("No funciona la caché");
      // return false;
    }

    if (connectivityResult != ConnectivityResult.none) {
      try {
        for (var session in await _dataSourceH.getSessions()) {
          await _dataSource.createSession(session);
        }
      } catch (e) {
        return false;
      }

      _dataSourceH.deleteAllSessions();
      return true;
    }

    return true;
  }

  @override
  Future<bool> deleteSession(GameSession session) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none
        ? _dataSourceH.deleteSession(session)
        : _dataSource.deleteSession(session);
  }

  @override
  Future<GameSession> getSession({int? id, String? username}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none
        ? _dataSourceH.getSession(id: id, username: username)
        : _dataSource.getSession(id: id, username: username);
  }

  @override
  Future<List<GameSession>> getSessions() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none
        ? _dataSourceH.getSessions()
        : _dataSource.getSessions();
  }
}
