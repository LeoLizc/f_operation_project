import 'package:f_operation_project/data/datasources/local/shared_preferences/auth_sh_ds.dart';
import 'package:f_operation_project/data/datasources/retome/auth_api_ds.dart';
import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/repositories/auth_repositoy.dart';

class ApiAuthRepository implements AuthRepository {
  final ApiAuthDataSource _apiAuthDataSource = ApiAuthDataSource();
  final AuthSharedPrefDataSource _authSharedPrefDataSource =
      AuthSharedPrefDataSource();

  @override
  bool get isLogged => _authSharedPrefDataSource.tokenExists();

  @override
  Future<bool> login(LoginModel auth) async {
    var token = await _apiAuthDataSource.login(auth);

    if (token != null) {
      await _authSharedPrefDataSource.saveToken(token);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    if (_authSharedPrefDataSource.tokenExists()) {
      await _authSharedPrefDataSource.deleteToken();
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Auth?> me() async {
    if (_authSharedPrefDataSource.tokenExists()) {
      var token = _authSharedPrefDataSource.token;
      var auth = await _apiAuthDataSource.me(token);
      return auth;
    } else {
      return null;
    }
  }

  @override
  Future<bool> register(Auth info) async {
    var result = await _apiAuthDataSource.register(info);

    if (result) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String? get token => _authSharedPrefDataSource.token;
}
