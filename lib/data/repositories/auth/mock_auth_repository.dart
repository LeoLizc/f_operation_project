import 'package:f_operation_project/domain/models/auth.dart';

import '../../../domain/repositories/auth_repositoy.dart';

class MockAuthRepository implements AuthRepository {
  final String _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwZXBpdG9fcGVyZXoiLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6MjUxNjIzOTAyMn0.qDt0fuAin0bJtdO-1RTQgBvbHtC-0TBY7RkEJS2BKOE";

  @override
  String? get token => _token;

  final Auth _auth = Auth(
      username: "username",
      password: "password",
      firstName: "firstName",
      lastName: "lastName");

  @override
  Future<Auth> me() async {
    return _auth;
  }

  @override
  Future<bool> login(LoginModel loginInfo) async {
    return true;
  }

  @override
  Future<bool> logout() async {
    return true;
  }

  @override
  Future<bool> register(Auth user) async {
    return true;
  }

  @override
  bool get isLogged => true;
}
