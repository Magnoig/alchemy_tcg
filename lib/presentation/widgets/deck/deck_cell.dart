import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/game_constants.dart';
import '../../../core/theme/game_theme.dart';
import '../../blocs/card_deck/card_deck_bloc.dart';
import '../../blocs/card_deck/card_deck_event.dart';
import '../../blocs/card_deck/card_deck_state.dart';
import 'card_stack.dart';

class DeckCell extends StatelessWidget {
  final double cellSize;

  const DeckCell({
    super.key,
    required this.cellSize,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = cellSize * 0.8;
    final cardHeight = cardWidth / GameConstants.cardAspectRatio;

    return BlocBuilder<CardDeckBloc, CardDeckState>(
      builder: (context, state) {
        if (state.cardImages.isEmpty) {
          return Card(
            color: GameTheme.deckColor,
            child: const Center(
              child: Text('Empty'),
            ),
          );
        }

        return Center(
          child: Draggable<String>(
            data: state.cardImages.last,
            feedback: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: Card(
                  child: Image.asset(
                    state.cardImages.last,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            childWhenDragging: CardStack(cardWidth: cardWidth, cardHeight: cardHeight),
            onDragEnd: (details) {
              if (details.wasAccepted) {
                context.read<CardDeckBloc>().add(RemoveTopCard());
              }
            },
            child: CardStack(cardWidth: cardWidth, cardHeight: cardHeight),
          ),
        );
      },
    );
  }
} 