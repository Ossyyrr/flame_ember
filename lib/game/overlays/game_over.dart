import 'package:ember_flame/core/model/score.dart';
import 'package:ember_flame/core/repository/score_repository.dart';
import 'package:ember_flame/game/services/ember_quest_game.dart';
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
          Positioned(
            top: 60,
            left: 36,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(playerName,
                    style: const TextStyle(color: Colors.white, fontSize: 24)),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/star.png',
                      scale: 24,
                    ),
                    Text(
                      game.starsCollected.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                width: 400,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          'Game Over',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Ranking',
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
                                height: MediaQuery.of(context).size.height >
                                        10000
                                    ? 600
                                    : MediaQuery.of(context).size.height / 2.5,
                                child: ListWheelScrollView(
                                    controller: FixedExtentScrollController(
                                        initialItem: scores.indexWhere(
                                            (element) =>
                                                element.name == playerName)),
                                    physics: const FixedExtentScrollPhysics(),
                                    itemExtent: 32,
                                    children: List.generate(
                                      scores.length,
                                      (index) => Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$index.                 ',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            '${scores[index].name}:       ${scores[index].score}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            }),
                      ],
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: IconButton(
                          onPressed: () {
                            game.reset();
                            game.overlays.remove('GameOver');
                          },
                          icon: const Icon(
                            Icons.play_circle,
                            color: Colors.white,
                            size: 50,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
