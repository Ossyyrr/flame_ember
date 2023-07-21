import 'package:ember_flame/game/overlays/widget/character_selector.dart';
import 'package:ember_flame/game/services/ember_quest_game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final EmberQuestGame game;
  final FocusNode focusNode;
  final Function(String playerName) setPlayerName;

  const MainMenu(
      {super.key,
      required this.game,
      required this.focusNode,
      required this.setPlayerName});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image(
                image: AssetImage('assets/images/bg_w.png'), fit: BoxFit.cover),
          ),
          Positioned(
              bottom: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Game by Patricia Manzanero',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: GoogleFonts.indieFlower().fontFamily,
                    ),
                  ),
                  Text(
                    'Assets by Borja Bandera',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: GoogleFonts.indieFlower().fontFamily,
                    ),
                  ),
                ],
              )),
          Center(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10.0),
              width: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/block_grass.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  const Text(
                    'Ember Flame',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: 'Player Name',
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      onChanged: (text) => setPlayerName(text),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Choose your character',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CharacterSelector(
                        asset: 'assets/images/pj1.png',
                        // backgroundColor: Colors.blue,
                        character: Character.ember,
                        game: game,

                        focusNode: focusNode,
                      ),
                      const SizedBox(width: 8),
                      CharacterSelector(
                        asset: 'assets/images/pj2.png',
                        // backgroundColor: Colors.amber,
                        character: Character.water,
                        game: game,
                        focusNode: focusNode,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (MediaQuery.of(context).size.height > 400) ...[
                    const Text(
                      'Use WAD or Arrow Keys for movement.\nSpace bar to jump.\nCollect as many stars as you can\nand avoid enemies!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
