import 'dart:convert';

import 'package:f_operation_project/domain/models/auth.dart';
import 'package:http/http.dart' as http;

class ApiAuthDataSource {
  final String _baseUrl = 'http://localhost:8000/api/v1';

  Future<bool> register(Auth info) async {
    try {
      var response = await http.post(Uri.parse('$_baseUrl/auth/register'),
          body: info.toJson());

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
      var response = await http.post(Uri.parse('$_baseUrl/auth/login'),
          body: auth.toJson());

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
        Uri.parse('$_baseUrl/auth/me'),
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
        Uri.parse('$_baseUrl/auth/refresh'),
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
