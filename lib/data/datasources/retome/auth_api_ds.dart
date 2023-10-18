import 'dart:convert';

import 'package:f_operation_project/domain/models/auth.dart';
import 'package:http/http.dart' as http;

class ApiAuthDataSource {
  final String _baseUrl =
      'http://ip172-18-0-74-cknlmbmfml8g00bp7h1g-8000.direct.labs.play-with-docker.com';

  Future<bool> register(Auth info) async {
    try {
      var response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(info.toJson()),
      );

      if (response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String?> login(LoginModel auth) async {
    try {
      var response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(auth.toJson()),
      );

      if (response.statusCode < 300) {
        return jsonDecode(response.body)['access_token'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Auth> me(String token) async {
    try {
      var response = await http.get(
        Uri.parse('$_baseUrl/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode < 300) {
        return Auth.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load session');
      }
    } catch (e) {
      throw Exception('Failed to load session');
    }
  }

  Future<String> refreshToken(String token) async {
    try {
      var response = await http.post(
        Uri.parse('$_baseUrl/refresh'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode < 300) {
        return jsonDecode(response.body)['access_token'];
      } else {
        throw Exception('Failed to load session');
      }
    } catch (e) {
      throw Exception('Failed to load session');
    }
  }
}
