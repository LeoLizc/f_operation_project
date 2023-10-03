class User {
  final int? id;
  final String username;
  final String birthDate;
  final int grade;
  final String school;
  int difficultyLevel;

  User({
    this.id,
    required this.username,
    // required this.firstName,
    // required this.lastName,
    required this.birthDate, // It comes in a format like this: Jun 9, 2023 5:01 PM
    required this.grade,
    required this.school,
    required this.difficultyLevel,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      // firstName: json['firstName'],
      // lastName: json['lastName'],
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
      'username': username,
      // 'firstName': firstName,
      // 'lastName': lastName,
      'grade': grade,
      'school': school,
      // birthDate should be in a format like this: Jun 9, 2023 5:01 PM
      'birthDate': birthDate,
      'difficultyLevel': difficultyLevel,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          birthDate == other.birthDate &&
          grade == other.grade &&
          school == other.school &&
          difficultyLevel == other.difficultyLevel;

  @override
  int get hashCode =>
      id.hashCode ^
      username.hashCode ^
      birthDate.hashCode ^
      grade.hashCode ^
      school.hashCode ^
      difficultyLevel.hashCode;
}
