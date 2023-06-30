class Score {
  String name;
  int score;

  Score({required this.name, required this.score});

  Map<String, dynamic> toMap() {
    return {'name': name, 'score': score};
  }

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      name: map['name'],
      score: map['score'],
    );
  }

  @override
  String toString() {
    return 'Score {name: $name, score: $score}';
  }
}
