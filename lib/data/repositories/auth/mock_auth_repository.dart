import 'package:f_operation_project/domain/models/user.dart';

import '../../../domain/repositories/auth_repositoy.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<User> getUser() async {
    return User(
      grade: 1,
      school: "MockColegio",
      birthDate: DateTime(2000, 1, 1).toString(),
      difficultyLevel: 1,
    );
  }

  @override
  Future<bool> login(String username, String password) async {
    return true;
  }

  @override
  Future<bool> logout() async {
    return true;
  }

  @override
  Future<bool> register(User user) async {
    return true;
  }
}
