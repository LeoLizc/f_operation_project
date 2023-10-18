import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/repositories/auth_repositoy.dart';

class ApiAuthRepository implements AuthRepository {
  @override
  // TODO: implement isLogged
  bool get isLogged => throw UnimplementedError();

  @override
  Future<bool> login(LoginModel auth) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Auth?> me() {
    // TODO: implement me
    throw UnimplementedError();
  }

  @override
  Future<bool> register(Auth info) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  // TODO: implement token
  String? get token => throw UnimplementedError();
}
