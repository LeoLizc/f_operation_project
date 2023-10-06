import 'package:hive/hive.dart';

part 'model_session.g.dart';

@HiveType(typeId: 1)
class Dato_db_session extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? username;

  @HiveField(2)
  int tSeconds;

  @HiveField(3)
  int score;

  @HiveField(4)
  int difficultyLevel;

  Dato_db_session(
      {this.id,
      this.username,
      required this.tSeconds,
      required this.score,
      required this.difficultyLevel});
}
