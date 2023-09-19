import 'package:f_operation_project/domain/models/user.dart';

import '../repositories/auth_repositoy.dart';

class AuthenticationUseCase {
  final AuthRepository _repository;

  AuthenticationUseCase(this._repository);

  Future<bool> login() async {
    return await _repository.login();
  }

  Future<bool> logout() async {
    return await _repository.logout();
  }

  Future<bool> register(User user) async {
    return await _repository.register(user);
  }
}
