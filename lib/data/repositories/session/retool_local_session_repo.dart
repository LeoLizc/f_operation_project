import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:f_operation_project/data/datasources/local/shared_preferences/session_sh_ds.dart';
import 'package:f_operation_project/data/datasources/retome/session_retool_ds.dart';
import 'package:f_operation_project/domain/models/session.dart';
import 'package:f_operation_project/domain/repositories/session_repository.dart';
import 'package:flutter/foundation.dart';

class RetoolLocalSessionRepository implements SessionRepository {
  final RetoolSessionDataSource _retoolDatasource = RetoolSessionDataSource();
  final SessionSharedPrefDataSource _sharedPrefDataSource =
      SessionSharedPrefDataSource();

  @override
  Future<bool> addSession(GameSession session) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    bool saved = await _sharedPrefDataSource.saveSession(session);

    if (!saved) {
      throw ErrorDescription("No funciona la caché");
      // return false;
    }

    if (connectivityResult != ConnectivityResult.none) {
      try {
        for (var session in await _sharedPrefDataSource.getSessions()) {
          await _retoolDatasource.createSession(session);
        }
      } catch (e) {
        return false;
      }

      _sharedPrefDataSource.deleteAllSessions();
      return true;
    }

    return true;
  }

  @override
  Future<bool> deleteSession(GameSession session) async {
    // ! The best option would be to implement a dirty bit in the local storage, but I don't have time
    // ! Instead I will delete the session from the local storage and the remote storage

    bool remoteRemoved = true,
        localRemoved = await _sharedPrefDataSource.removeSession(session);

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        remoteRemoved = await _retoolDatasource.deleteSession(session);
      } catch (e) {
        return false;
      }
    }

    return remoteRemoved || localRemoved;
  }

  @override
  Future<GameSession> getSession({required int id}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      try {
        return await _retoolDatasource.getSession(id: id);
      } catch (e) {
        throw ErrorDescription("Connection Error.");
      }
    }

    try {
      var localSession = await _sharedPrefDataSource.getSessionById(id);
      if (localSession != null) {
        return localSession;
      }
      throw ErrorDescription(
          "Error getting session from cache. Session not found");
    } catch (e) {
      throw ErrorDescription("No connection and no cache.");
    }
  }

  @override
  Future<List<GameSession>> getSessions({String? username}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      try {
        return await _retoolDatasource.getSessions(username: username);
      } catch (e) {
        throw ErrorDescription("Connection Error.");
      }
    }

    try {
      var localSessions = await _sharedPrefDataSource.getSessions();
      return localSessions;
    } catch (e) {
      throw ErrorDescription("No connection and no cache.");
    }
  }
}
