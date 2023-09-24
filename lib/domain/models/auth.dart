// Class that represents the information needed to authenticate a user.
import 'package:f_operation_project/domain/models/user.dart';

class Auth {
  final String username;
  final String password;
  final String firstName;
  final String lastName;

  Auth({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      username: json['username'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class LoginModel {
  final String username;
  final String password;

  LoginModel({
    required this.username,
    required this.password,
  });
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
    required int difficultyLevel,
    required String firstName,
    required String lastName,
  })  : userInformation = User(
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
}
