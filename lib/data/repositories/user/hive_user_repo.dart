import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:f_operation_project/data/datasources/Local/user_hive_ds.dart';
import 'package:f_operation_project/data/datasources/retome/user_retool_ds.dart';
import 'package:f_operation_project/domain/models/user.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';

class HiveUserRepository implements UserRepository {
  final HiveUserDataSource _dataSourceH = HiveUserDataSource();
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
  Future<User> getUser({int? id, String? username}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dataSourceH.getUsuarioActual();
    } else {
      User user = await _dataSource.getUser(id: id, username: username);
      _dataSourceH.usuarioactual(user);
      return user;
    }
  }

  @override
  Future<User> updateUser(User user) async {
    bool saved = await _dataSourceH.actualizarUsuarioActual(user);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (saved && connectivityResult != ConnectivityResult.none) {
      return _dataSource.updateUser(user);
    } else {
      return user;
    }
  }
}
