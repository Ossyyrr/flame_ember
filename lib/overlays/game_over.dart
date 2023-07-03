import 'package:flame_doc/core/model/score.dart';
import 'package:flame_doc/core/repository/score_repository.dart';
import 'package:flame_doc/ember_quest_game.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  // Reference to parent game.
  final EmberQuestGame game;
  final String playerName;
  const GameOver({super.key, required this.game, required this.playerName});

  @override
  Widget build(BuildContext context) {
    ScoreRepository.updateUserScore(playerName, game.starsCollected);

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image(
                image: AssetImage('assets/images/bg_f.png'), fit: BoxFit.cover),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Game Over',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Scores:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 16),
                  StreamBuilder(
                      stream: ScoreRepository.scoresStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white));
                        }
                        final scores = snapshot.data as List<Score>;

                        return SizedBox(
                          height: 200,
                          child: ListView(
                            children: [
                              for (final score in scores)
                                Text(
                                  '${score.name}: ${score.score}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 75,
                    child: ElevatedButton(
                      onPressed: () {
                        game.reset();
                        game.overlays.remove('GameOver');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Play Again',
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
