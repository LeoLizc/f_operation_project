import 'package:f_operation_project/domain/models/auth.dart';

import '../models/user.dart';

abstract class AuthRepository {
  Future<bool> login(LoginModel auth);
  Future<bool> logout();
  Future<bool> register(Auth info);
  Future<Auth> me();
}
