import 'dart:convert';

import 'package:f_operation_project/data/datasources/local/shared_preferences/shared_preferences_ds.dart';
import 'package:f_operation_project/domain/models/user.dart';

class UserSharedPreferencesDataSource {
  final SharedPreferencesDataSource _sharedPreferences =
      SharedPreferencesDataSource();

  Future<bool> saveUser(User user) async {
    try {
      await _sharedPreferences.save(
        'User',
        jsonEncode(user.toJson()),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  bool exists() {
    return _sharedPreferences.exists('User');
  }

  Future<User?> getUser() async {
    try {
      var userJson = await _sharedPreferences.get<String>('User');
      return User.fromJson(jsonDecode(userJson!));
    } catch (e) {
      return null;
    }
  }
}
