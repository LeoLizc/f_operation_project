import 'package:f_operation_project/domain/models/auth.dart';

abstract class AuthRepository {
  String? get token;

  Future<bool> login(LoginModel auth);
  Future<bool> logout();
  Future<bool> register(Auth info);
  Future<Auth?> me();
}
