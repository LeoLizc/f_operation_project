import 'package:f_operation_project/domain/models/user.dart';

abstract class UserRepository {
  Future<User> getUser({String id, String username});
  // Future<List<User>> getUsers();
  Future<bool> addUser(User user);
  Future<bool> updateUser(User user);
  Future<bool> deleteUser(User user);
}
