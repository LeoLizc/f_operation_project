import 'package:f_operation_project/domain/models/auth.dart';
import 'package:f_operation_project/domain/repositories/auth_repositoy.dart';
import 'package:get/get.dart';

class MemoryAuthRepository implements AuthRepository {
  String? _token;
  Auth? _user;

  @override
  String? get token => _token;

  final List<Auth> _users = [
    Auth(
      username: "username",
      password: "password",
      firstName: "firstName",
      lastName: "lastName",
    ),
    Auth(
      username: "qwerty",
      password: "asdfghjkl",
      firstName: "firstName",
      lastName: "lastName",
    ),
  ];

  @override
  Future<bool> login(LoginModel auth) async {
    final user = _users.firstWhereOrNull(
      (user) =>
          user.username == auth.username && user.password == auth.password,
    );

    if (user == null) {
      return false;
    } else {
      _token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwZXBpdG9fcGVyZXoiLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6MjUxNjIzOTAyMn0.qDt0fuAin0bJtdO-1RTQgBvbHtC-0TBY7RkEJS2BKOE";

      _user = user;
      return true;
    }
  }

  @override
  Future<bool> logout() {
    _token = null;
    return Future.value(true);
  }

  @override
  Future<Auth?> me() {
    return Future.value(_user);
  }

  @override
  Future<bool> register(Auth info) {
    _users.add(info);
    _user = info;
    _token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwZXBpdG9fcGVyZXoiLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6MjUxNjIzOTAyMn0.qDt0fuAin0bJtdO-1RTQgBvbHtC-0TBY7RkEJS2BKOE";
    return Future.value(true);
  }
}
