import 'package:f_operation_project/data/datasources/local/shared_preferences/shared_preferences_ds.dart';
import 'package:f_operation_project/data/repositories/user/retool_user_repo.dart';
import 'package:f_operation_project/domain/models/user.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';

class CachedRetoolUserRepository implements UserRepository {
  final UserRepository _userRepository = RetoolUserRepository();
  final SharedPreferencesDataSource _sharedPreferencesDataSource =
      SharedPreferencesDataSource();

  @override
  Future<bool> addUser(User user) {
    return _userRepository.addUser(user);
  }

  @override
  Future<bool> deleteUser(User user) {
    return _userRepository.deleteUser(user);
  }

  @override
  Future<User> getUser({int? id, String? username}) async {
    if (_sharedPreferencesDataSource.exists('user')) {
      return (await _sharedPreferencesDataSource.get<User>('user'))!;
    }

    User user = await _userRepository.getUser(id: id, username: username);

    await _sharedPreferencesDataSource.save('user', user);

    return user;
  }

  @override
  Future<User> updateUser(User user) {
    return _userRepository.updateUser(user);
  }
}
