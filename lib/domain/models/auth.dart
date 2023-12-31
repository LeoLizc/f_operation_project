// Class that represents the information needed to authenticate a user.
import 'package:f_operation_project/domain/models/user.dart';

class Auth {
  final String username;
  final String? password;
  final String firstName;
  final String lastName;

  Auth({
    required this.username,
    this.password,
    required this.firstName,
    required this.lastName,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      username: json['username'],
      password: json['password'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Auth &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password &&
          firstName == other.firstName &&
          lastName == other.lastName;

  @override
  int get hashCode =>
      username.hashCode ^
      password.hashCode ^
      firstName.hashCode ^
      lastName.hashCode;
}

class LoginModel {
  final String username;
  final String password;

  LoginModel({
    required this.username,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginModel &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password;

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}

// Class that represents the information needed to register a user.
class RegisterModel {
  final User userInformation;
  final Auth authInformation;

  RegisterModel({
    required String username,
    required String password,
    required String birthDate,
    required int grade,
    required String school,
    int difficultyLevel = 1,
    required String firstName,
    required String lastName,
  })  : userInformation = User(
          username: username,
          birthDate: birthDate,
          grade: grade,
          school: school,
          difficultyLevel: difficultyLevel,
        ),
        authInformation = Auth(
          username: username,
          password: password,
          firstName: firstName,
          lastName: lastName,
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterModel &&
          runtimeType == other.runtimeType &&
          userInformation == other.userInformation &&
          authInformation == other.authInformation;

  @override
  int get hashCode => userInformation.hashCode ^ authInformation.hashCode;
}
