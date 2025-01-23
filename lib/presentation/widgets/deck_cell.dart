import 'package:flutter/material.dart';
import '../../core/constants/game_constants.dart';
import '../../core/theme/game_theme.dart';
import 'card_deck.dart';

class DeckCell extends StatelessWidget {
  final double cellSize;

  const DeckCell({
    Key? key,
    required this.cellSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          color: GameTheme.deckColor,
          child: Center(
            child: Text(
              'Deck',
              style: GameTheme.cellText,
            ),
          ),
        ),
        Positioned(
          bottom: -cellSize,
          right: -cellSize * GameConstants.deckOverflowFactor,
          child: SizedBox(
            width: cellSize * GameConstants.cardAspectRatio,
            height: cellSize * GameConstants.cardAspectRatio * 1.3,
            child: CardDeck(),
          ),
        ),
      ],
    );
  }
} 