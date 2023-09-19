import '../models/user.dart';

abstract class AuthRepository {
  Future<User> getUser();
  Future<bool> login();
  Future<bool> logout();
  Future<bool> register(User user);
}
