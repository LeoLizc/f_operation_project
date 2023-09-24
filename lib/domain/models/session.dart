class GameSession {
  final int? id;
  String? username;
  final int tSeconds;
  final int score;
  int difficultyLevel;

  GameSession({
    required this.id,
    this.username,
    required this.tSeconds,
    required this.score,
    required this.difficultyLevel,
  });

  factory GameSession.fromJson(Map<String, dynamic> json) {
    return GameSession(
      id: json['id'],
      username: json['userId'],
      tSeconds: json['tSeconds'],
      score: json['score'],
      difficultyLevel: json['difficultyLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': username,
      'tSeconds': tSeconds,
      'score': score,
      'difficultyLevel': difficultyLevel,
    };
  }
}
