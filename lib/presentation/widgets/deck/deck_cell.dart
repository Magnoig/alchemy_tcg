import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/game_constants.dart';
import '../../../core/theme/game_theme.dart';
import '../../blocs/card_deck/card_deck_bloc.dart';
import '../../blocs/card_deck/card_deck_event.dart';
import '../../blocs/card_deck/card_deck_state.dart';

class DeckCell extends StatelessWidget {
  final double cellSize;

  const DeckCell({
    Key? key,
    required this.cellSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardWidth = cellSize * 0.5;
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
            childWhenDragging: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (int i = 2; i >= 0; i--)
                    Positioned(
                      top: -i * 2.0,
                      right: -i * 2.0,
                      child: Card(
                        child: Image.asset(
                          'assets/images/card_verso.png',
                          width: cardWidth,
                          height: cardHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            onDragEnd: (details) {
              if (details.wasAccepted) {
                context.read<CardDeckBloc>().add(RemoveTopCard());
              }
            },
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (int i = 2; i >= 0; i--)
                    Positioned(
                      top: -i * 2.0,
                      right: -i * 2.0,
                      child: Card(
                        child: Image.asset(
                          'assets/images/card_verso.png',
                          width: cardWidth,
                          height: cardHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 