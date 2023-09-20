import 'package:f_operation_project/domain/models/user.dart';
import 'package:f_operation_project/domain/use_cases/authentication_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthenticationUseCase _authUseCase = Get.find<AuthenticationUseCase>();

  final RxBool _isAuthenticated = false.obs;

  bool get isAuthenticated => _isAuthenticated.value;

  void login(String username, String password) async {
    _isAuthenticated.value = await _authUseCase.login(username, password);
  }

  void logout() async {
    _isAuthenticated.value = await _authUseCase.logout();
  }

  Future<bool> register(
      {required String username,
      required String password,
      required int grade,
      required String school,
      required int birthDay,
      required int birthMonth,
      required int birthYear}) async {
    User user = User(
      grade: grade,
      school: school,
      birthDate: DateTime(birthYear, birthMonth, birthDay).toString(),
      difficultyLevel: 1,
    );
    _isAuthenticated.value = await _authUseCase.register(user);
    return _isAuthenticated.value;
  }
}
