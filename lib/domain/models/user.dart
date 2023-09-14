class User {
  final int id;
  final String firstName;
  final String lastName;
  final String birthDate;
  final int grade;
  final String school;
  final int difficultyLevel;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate, // It comes in a format like this: Jun 9, 2023 5:01 PM
    required this.grade,
    required this.school,
    required this.difficultyLevel,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      grade: json['grade'],
      school: json['school'],
      // birthDate should be in a format like this: Jun 9, 2023 5:01 PM
      birthDate: json['birthDate'],
      difficultyLevel: json['difficultyLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'grade': grade,
      'school': school,
      // birthDate should be in a format like this: Jun 9, 2023 5:01 PM
      'birthDate': birthDate,
      'difficultyLevel': difficultyLevel,
    };
  }
}
