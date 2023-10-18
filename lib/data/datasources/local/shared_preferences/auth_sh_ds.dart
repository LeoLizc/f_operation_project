import 'dart:convert';

import 'package:f_operation_project/data/datasources/local/shared_preferences/shared_preferences_ds.dart';
import 'package:f_operation_project/domain/models/auth.dart';

class AuthSharedPrefDataSource {
  final SharedPreferencesDataSource _sharedPreferences =
      SharedPreferencesDataSource();

  Future<bool> saveToken(String token) async {
    try {
      await _sharedPreferences.save(
        'token',
        token,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getToken() async {
    try {
      var token = await _sharedPreferences.get<String>('token');
      return token;
    } catch (e) {
      return null;
    }
  }

  String get token {
    try {
      var token = _sharedPreferences.syncGet<String>('token');
      return token!;
    } catch (e) {
      return '';
    }
  }

  Future<bool> deleteToken() async {
    try {
      await _sharedPreferences.delete('token');
      return true;
    } catch (e) {
      return false;
    }
  }

  bool tokenExists() {
    try {
      return _sharedPreferences.exists('token');
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveMe(Auth me) async {
    try {
      _sharedPreferences.save('me', jsonEncode(me.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Auth?> getMe() async {
    try {
      var me = await _sharedPreferences.get<String>('me');
      if (me != null) {
        return Auth.fromJson(jsonDecode(me));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
