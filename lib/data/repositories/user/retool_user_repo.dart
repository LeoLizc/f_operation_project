import 'package:f_operation_project/data/datasources/retome/user_retool_ds.dart';
import 'package:f_operation_project/domain/models/user.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';

class RetoolUserRepository implements UserRepository {
  final RetoolUserDataSource _dataSource = RetoolUserDataSource();

  @override
  Future<bool> addUser(User user) {
    return _dataSource.createUser(user);
  }

  @override
  Future<bool> deleteUser(User user) {
    return _dataSource.deleteUser(user);
  }

  @override
  Future<User> getUser({int? id, String? username}) {
    return _dataSource.getUser(id: id, username: username);
  }

  @override
  Future<User> updateUser(User user) {
    return _dataSource.updateUser(user);
  }
}
