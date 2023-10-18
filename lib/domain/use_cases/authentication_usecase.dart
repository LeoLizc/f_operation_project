import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';

import '../repositories/auth_repositoy.dart';

class AuthenticationUseCase {
  final AuthRepository _repository;
  final UserRepository _userRepository;

  AuthenticationUseCase(
      {required AuthRepository authRepository,
      required UserRepository userRepository})
      : _repository = authRepository,
        _userRepository = userRepository;

  Future<bool> login(String username, String password) async {
    bool success = await _repository
        .login(LoginModel(username: username, password: password));

    if (success) {
      _userRepository.getUser(username: username);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    return await _repository.logout();
  }

  Future<bool> register(RegisterModel userInfo) async {
    bool auth = await _repository.register(userInfo.authInformation);

    if (auth) {
      return _userRepository.addUser(userInfo.userInformation);
    } else {
      return false;
    }
  }

  bool isAuthenticated() {
    return _repository.isLogged;
  }
}
