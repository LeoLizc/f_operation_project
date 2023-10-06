import 'package:hive/hive.dart';

part 'model_user.g.dart';

@HiveType(typeId: 0)
class Dato_db extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String birthDate;

  @HiveField(3)
  int grade;

  @HiveField(4)
  String school;

  @HiveField(5)
  int difficultyLevel;

  Dato_db(
      {this.id,
      required this.username,
      required this.birthDate,
      required this.grade,
      required this.school,
      required this.difficultyLevel});
}
