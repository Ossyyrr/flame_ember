import 'dart:async';

import 'package:ember_flame/core/model/score.dart';
import 'package:ember_flame/core/services/firestore.dart';

class ScoreRepository {
  static late List<Score> gameScores;

  static final StreamController<List<Score>> scoresController =
      StreamController<List<Score>>.broadcast();
  static Stream<List<Score>> get scoresStream => scoresController.stream;

  static void updateScores(List<Score> newScores) {
    gameScores = newScores;
    scoresController.sink.add(newScores);
  }

  static void getScores() async {
    final scores = await Firestore.getScores();
    updateScores(scores);
  }

  static void updateUserScore(String name, int score) async {
    if (gameScores.length < 25 ||
        gameScores.isEmpty ||
        score > gameScores.last.score) {
      await Firestore.addScore(name, score);
    }
    final scores = await Firestore.getScores();
    updateScores(scores);
  }
}
