import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ember_flame/core/model/score.dart';

class Firestore {
  Firestore() {
    init();
  }

  static FirebaseFirestore _instance = FirebaseFirestore.instance;

  static FirebaseFirestore get instance => _instance;

  static Future<void> init() async {
    _instance = FirebaseFirestore.instance;
  }

  static Future<void> addScore(String name, int score) async {
    await _instance.collection('scores').add({
      'name': name,
      'score': score,
    });
  }

  static Future<List<Score>> getScores() async {
    final List<Score> scores = [];

    final data = await _instance
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(20)
        .get();

    for (final doc in data.docs) {
      scores.add(Score.fromMap(doc.data()));
    }

    return scores;
  }
}
