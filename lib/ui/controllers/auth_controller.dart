import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/use_cases/authentication_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // * DEPENDENCIES
  final AuthenticationUseCase _authUseCase;

  // * CONSTRUCTOR
  AuthController(this._authUseCase);

  final RxBool _isAuthenticated = false.obs;

  bool get isAuthenticated => _isAuthenticated.value;

  Future<bool> login(String username, String password) async {
    return _isAuthenticated.value =
        await _authUseCase.login(username, password);
  }

  Future<void> logout() async {
    _isAuthenticated.value = !(await _authUseCase.logout());
  }

  Future<bool> register(
      {required String username,
      required firstName,
      required lastName,
      required String password,
      required int grade,
      required String school,
      required int birthDay,
      required int birthMonth,
      required int birthYear}) async {
    RegisterModel user = RegisterModel(
      grade: grade,
      school: school,
      birthDate: DateTime(birthYear, birthMonth, birthDay).toString(),
      difficultyLevel: 1,
      username: username,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    return await _authUseCase.register(user);
  }
}
