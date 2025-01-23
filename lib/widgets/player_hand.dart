import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_grid/card_grid_bloc.dart';
import '../bloc/card_grid/card_grid_event.dart';
import '../bloc/player_hand/player_hand_bloc.dart';
import '../bloc/player_hand/player_hand_event.dart';
import '../bloc/player_hand/player_hand_state.dart';
import '../constants/game_constants.dart';
import '../theme/game_theme.dart';

class PlayerHand extends StatelessWidget {
  final Function(BuildContext, String) onShowZoom;

  const PlayerHand({
    Key? key,
    required this.onShowZoom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerHandBloc, PlayerHandState>(
      builder: (context, state) {
        return DragTarget<String>(
          builder: (context, candidateData, rejectedData) {
            return Container(
              height: GameConstants.handHeight,
              color: GameTheme.handBackgroundColor,
              child: state.cards.isEmpty
                  ? Center(
                      child: Text(
                        'Arraste cartas do deck para cá',
                        style: GameTheme.handText,
                      ),
                    )
                  : ReorderableListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.cards.length,
                      onReorder: (oldIndex, newIndex) {
                        context.read<PlayerHandBloc>().add(
                          ReorderCards(oldIndex, newIndex),
                        );
                      },
                      itemBuilder: (context, index) {
                        final cardPath = state.cards[index];
                        return Padding(
                          key: ValueKey(cardPath),
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onLongPress: () => onShowZoom(context, cardPath),
                            child: Draggable<String>(
                              data: cardPath,
                              onDragStarted: () {
                                context.read<CardGridBloc>().add(
                                  StartDraggingCard(cardPath),
                                );
                              },
                              onDragEnd: (_) {
                                context.read<CardGridBloc>().add(
                                  StopDraggingCard(),
                                );
                              },
                              onDragCompleted: () {
                                context.read<PlayerHandBloc>().add(
                                  RemoveCard(cardPath),
                                );
                              },
                              feedback: Image.asset(
                                cardPath,
                                height: GameConstants.handCardHeight,
                                fit: BoxFit.contain,
                              ),
                              childWhenDragging: Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  'assets/images/card_verso.png',
                                  height: GameConstants.handCardHeight,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Image.asset(
                                cardPath,
                                height: GameConstants.handCardHeight,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
          onWillAccept: (data) => data != null && !state.cards.contains(data),
          onAccept: (cardPath) {
            context.read<PlayerHandBloc>().add(AddCard(cardPath));
          },
        );
      },
    );
  }
} 