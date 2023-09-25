import 'package:f_operation_project/domain/models/user.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';

class MemoryUserRepository implements UserRepository {
  int _id = 0;
  final _users = <User>[];

  @override
  Future<bool> addUser(User user) async {
    _id++;
    _users.add(User(
      id: _id,
      username: user.username,
      grade: user.grade,
      school: user.school,
      birthDate: user.birthDate,
      difficultyLevel: user.difficultyLevel,
    ));
    return Future.value(true);
  }

  @override
  Future<bool> deleteUser(User user) {
    _users.remove(user);
    return Future.value(true);
  }

  @override
  Future<User> getUser({String? id, String? username}) {
    return Future.value(_users.firstWhere(
        (user) => user.id == int.parse(id!) || user.username == username));
  }
}
