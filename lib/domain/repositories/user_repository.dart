import 'package:f_operation_project/domain/models/user.dart';

abstract class UserRepository {
  Future<User> getUser({int? id, String? username});
  // Future<List<User>> getUsers();
  Future<bool> addUser(User user);
  Future<User> updateUser(User user);
  Future<bool> deleteUser(User user);
}
