import 'package:alchemy_tcg/core/theme/game_theme.dart';
import 'package:flutter/material.dart';

class DeckBackground extends StatelessWidget {
  const DeckBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: GameTheme.deckColor,
      child: const Center(
        child: Text('Deck'),
      ),
    );
  }
}
