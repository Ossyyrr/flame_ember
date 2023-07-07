import 'package:ember_flame/utils/globals.dart';
import 'package:flutter/material.dart';

enum Character { ember, water }

class CharacterSelector extends StatefulWidget {
  const CharacterSelector(
      {super.key,
      required this.asset,
      this.backgroundColor,
      required this.character});
  final String asset;
  final Color? backgroundColor;
  final Character character;
  @override
  State<CharacterSelector> createState() => _CharacterSelectorState();
}

class _CharacterSelectorState extends State<CharacterSelector> {
  Color bgColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Globals.selectedCharacter = widget.character,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() {
            // Cambiar el color de fondo a blanco cuando se pasa el ratón por encima
            bgColor = widget.backgroundColor ?? Colors.white;
          });
        },
        onExit: (_) {
          setState(() {
            // Restaurar el color de fondo transparente cuando se retira el ratón
            bgColor = Colors.transparent;
          });
        },
        child: CircleAvatar(
          backgroundColor: bgColor,
          radius: 50,
          backgroundImage: AssetImage(widget.asset),
        ),
      ),
    );
  }
}
