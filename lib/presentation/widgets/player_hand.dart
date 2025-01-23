import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/card_grid/card_grid_bloc.dart';
import '../blocs/card_grid/card_grid_event.dart';
import '../blocs/player_hand/player_hand_bloc.dart';
import '../blocs/player_hand/player_hand_event.dart';
import '../blocs/player_hand/player_hand_state.dart';
import '../../core/constants/game_constants.dart';
import '../../core/theme/game_theme.dart';

class PlayerHand extends StatefulWidget {
  final Function(BuildContext, String) onShowZoom;

  const PlayerHand({
    Key? key,
    required this.onShowZoom,
  }) : super(key: key);

  @override
  State<PlayerHand> createState() => _PlayerHandState();
}

class _PlayerHandState extends State<PlayerHand> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerHandBloc, PlayerHandState>(
      builder: (context, state) {
        return DragTarget<String>(
          builder: (context, candidateData, rejectedData) {
            return GestureDetector(
              onHorizontalDragUpdate: (details) {
                _scrollController.position.moveTo(
                  _scrollController.offset - details.delta.dx,
                );
              },
              child: Container(
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
                        scrollController: _scrollController,
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
                            key: ValueKey('$cardPath-$index'),
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onLongPress: () => widget.onShowZoom(context, cardPath),
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