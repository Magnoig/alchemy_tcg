import 'package:alchemy_tcg/core/theme/game_theme.dart';
import 'package:flutter/material.dart';

class BoardBackground extends StatelessWidget {
  const BoardBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: GameTheme.spellTrapBackgroundColor,
      child: const Center(
        child: Text('Spell/Trap'),
      ),
    );
  }
}