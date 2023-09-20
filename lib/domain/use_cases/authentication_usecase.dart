import 'package:f_operation_project/domain/models/user.dart';
import 'package:get/get.dart';

import '../repositories/auth_repositoy.dart';

class AuthenticationUseCase {
  final AuthRepository _repository = Get.find();

  AuthenticationUseCase();

  Future<bool> login(String username, String password) async {
    return await _repository.login(username, password);
  }

  Future<bool> logout() async {
    return await _repository.logout();
  }

  Future<bool> register(User user) async {
    return await _repository.register(user);
  }
}
