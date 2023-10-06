import 'dart:convert';
import 'package:f_operation_project/domain/models/user.dart';
import 'package:http/http.dart' as http;

class RetoolUserDataSource {
  final String _url = 'https://retoolapi.dev/b2zbUw/data';

  Future<User> getUser({int? id, String? username}) async {
    String query = '';

    if (id != null) {
      query = '?id=$id';
    } else if (username != null) {
      query = '?username=$username';
    }

    final response = await http.get(Uri.parse(
      _url + query,
    ));
    if (response.statusCode == 200) {
      final users = jsonDecode(response.body) as List;
      final user = users.firstWhere(
        (element) => element['id'] == id || element['username'] == username,
      );
      return User.fromJson(user);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$_url/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<bool> createUser(User user) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<bool> deleteUser(User user) async {
    final response = await http.delete(
      Uri.parse('$_url/${user.id}'),
    );
    if (response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
