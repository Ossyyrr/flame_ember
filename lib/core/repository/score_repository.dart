import 'dart:async';

import 'package:ember_flame/core/model/score.dart';
import 'package:ember_flame/services/firestore.dart';

class ScoreRepository {
  static final StreamController<List<Score>> scoresController =
      StreamController<List<Score>>.broadcast();
  static Stream<List<Score>> get scoresStream => scoresController.stream;

  static void updateScores(List<Score> newScores) {
    scoresController.sink.add(newScores);
  }

  static updateUserScore(String name, int score) async {
    await Firestore.addScore(name, score);
    final scores = await Firestore.getScores();
    updateScores(scores);
  }
}
