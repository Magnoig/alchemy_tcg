import 'package:alchemy_tcg/core/theme/game_theme.dart';
import 'package:flutter/material.dart';

class GraveyardBackground extends StatelessWidget {
  const GraveyardBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: GameTheme.deckBackgroundColor,
      child: const Center(
        child: Text('Graveyard'),
      ),
    );
  }
}