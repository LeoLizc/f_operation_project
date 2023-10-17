import 'dart:convert';

import 'package:f_operation_project/data/datasources/local/shared_preferences/shared_preferences_ds.dart';
import 'package:f_operation_project/domain/models/session.dart';

class SessionSharedPrefDataSource {
  SharedPreferencesDataSource _source = SharedPreferencesDataSource();

  Future<bool> saveSession(GameSession session) async {
    try {
      if (session.id == null) {
        var key = await _addSessionKey();
        _source.save(
          key,
          jsonEncode(session.toJson()),
        );
      } else {
        _source.save(
          await _addSessionKey(session.id!),
          jsonEncode(session.toJson()),
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<GameSession>> getSessions() async {
    try {
      var keys = await _getSessionKeys();
      var sessions = <GameSession>[];
      for (var key in keys) {
        var sessionJson = await _source.get<String>(key);
        sessions.add(GameSession.fromJson(jsonDecode(sessionJson!)));
      }
      return sessions;
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> _getSessionKeys() async {
    try {
      var keys = await _source.get<List<String>>('keys');
      keys ??= [];
      return keys;
    } catch (e) {
      return [];
    }
  }

  Future<String> _addSessionKey([int? id]) async {
    var keys = await _getSessionKeys();
    String key;
    if (id == null) {
      if (keys.isEmpty) {
        key = '1';
      } else {
        var lastKey = keys.last;
        var lastId = int.parse(lastKey);
        key = '${lastId + 1}';
      }
    } else {
      key = '$id';
    }

    keys.add(key);
    await _source.save<List<String>>('keys', keys);
    return key;
  }
}
