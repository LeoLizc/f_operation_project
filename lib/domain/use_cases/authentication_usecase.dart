import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';
import 'package:get/get.dart';

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
    return await _repository
        .login(LoginModel(username: username, password: password));
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
}
