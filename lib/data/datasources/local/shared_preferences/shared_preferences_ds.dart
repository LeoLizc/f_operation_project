import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataSource {
  late SharedPreferences sharedPreferences;

  SharedPreferencesDataSource() {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  Future<void> save<T>(String key, T value) async {
    if (value is String) {
      await sharedPreferences.setString(key, value);
    } else if (value is int) {
      await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    } else {
      throw Exception('SharedPreferencesDataSource: Type not supported');
    }
  }

  Future<T?> get<T>(String key) async {
    if (T == String) {
      return sharedPreferences.getString(key) as T?;
    } else if (T == int) {
      return sharedPreferences.getInt(key) as T?;
    } else if (T == double) {
      return sharedPreferences.getDouble(key) as T?;
    } else if (T == bool) {
      return sharedPreferences.getBool(key) as T?;
    } else if (T == List<String>) {
      return sharedPreferences.getStringList(key) as T?;
    } else {
      throw Exception('SharedPreferencesDataSource: Type not supported');
    }
  }

  Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
  }

  Future<void> clear() async {
    await sharedPreferences.clear();
  }

  bool exists(String key) {
    return sharedPreferences.containsKey(key);
  }
}
