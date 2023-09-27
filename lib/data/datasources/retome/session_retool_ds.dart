import 'dart:convert';
import 'package:f_operation_project/domain/models/session.dart';
import 'package:http/http.dart' as http;

class RetoolSessionDataSource {
  final String _url = 'https://retoolapi.dev/lmqGjO/session';

  Future<GameSession> getSession({int? id, String? username}) async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final sessions = jsonDecode(response.body) as List;
      final session = sessions.firstWhere(
        (element) => element['id'] == id || element['username'] == username,
      );
      return GameSession.fromJson(session);
    } else {
      throw Exception('Failed to load session');
    }
  }

  Future<List<GameSession>> getSessions() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode < 300) {
      final sessions = jsonDecode(response.body) as List;
      return sessions.map((e) => GameSession.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load sessions');
    }
  }

  Future<GameSession> updateSession(GameSession session) async {
    final response = await http.put(
      Uri.parse('$_url/${session.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(session.toJson()),
    );
    if (response.statusCode < 300) {
      return GameSession.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update session');
    }
  }

  Future<bool> createSession(GameSession session) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(session.toJson()),
    );
    if (response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Failed to create session');
    }
  }

  Future<bool> deleteSession(GameSession session) async {
    final response = await http.delete(
      Uri.parse('$_url/${session.id}'),
    );
    if (response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Failed to delete session');
    }
  }
}
