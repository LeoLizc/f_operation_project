import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool _isAuthenticated = false.obs;

  bool get isAuthenticated => _isAuthenticated.value;

  void login(String username, String password) {
    _isAuthenticated.value = true;
  }

  void logout() {
    _isAuthenticated.value = false;
  }

  void register(String username, String password) {
    _isAuthenticated.value = true;
  }
}
