import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:f_operation_project/data/datasources/local/shared_preferences/user_sh_ds.dart';
import 'package:f_operation_project/data/repositories/user/retool_user_repo.dart';
import 'package:f_operation_project/domain/models/user.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';

class CachedRetoolUserRepository implements UserRepository {
  final UserRepository _userRepository = RetoolUserRepository();
  final UserSharedPreferencesDataSource _sharedPreferencesDataSource =
      UserSharedPreferencesDataSource();

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
    if (_sharedPreferencesDataSource.exists()) {
      var localUser = (await _sharedPreferencesDataSource.getUser())!;

      if (localUser.id == id || localUser.username == username) {
        return localUser;
      }
    }

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No hay conexión a internet');
    }

    var user = await _userRepository.getUser(id: id, username: username);
    await _sharedPreferencesDataSource.saveUser(user);

    return user;
  }

  @override
  Future<User> updateUser(User user) async {
    _sharedPreferencesDataSource.saveUser(user);

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      try {
        return await _userRepository.updateUser(user);
      } catch (e) {
        throw Exception('No se pudo actualizar el usuario');
      }
    }

    return user;
  }
}
