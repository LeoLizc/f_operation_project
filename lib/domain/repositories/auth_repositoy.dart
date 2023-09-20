import '../models/user.dart';

abstract class AuthRepository {
  Future<User> getUser();
  Future<bool> login(String username, String password);
  Future<bool> logout();
  Future<bool> register(User user);
}
