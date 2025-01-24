import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/game_constants.dart';
import '../../../core/theme/game_theme.dart';
import '../../blocs/player_hand/player_hand_bloc.dart';
import '../../blocs/player_hand/player_hand_event.dart';
import '../../blocs/player_hand/player_hand_state.dart';

class PlayerHand extends StatefulWidget {
  final Function(BuildContext, String) onShowZoom;

  const PlayerHand({
    super.key,
    required this.onShowZoom,
  });

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

  void _handleHorizontalDragUpdate(DragUpdateDetails details) {
    _scrollController.position.moveTo(
      _scrollController.offset - details.delta.dx,
      clamp: true,
    );
  }

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
                  ? const Center(
                      child: Text('Empty Hand'),
                    )
                  : GestureDetector(
                      onHorizontalDragUpdate: _handleHorizontalDragUpdate,
                      child: ReorderableListView.builder(
                        scrollController: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.cards.length,
                        itemBuilder: (context, index) {
                          final cardPath = state.cards[index];
                          return Draggable<String>(
                            key: ValueKey('$cardPath-$index'),
                            data: cardPath,
                            feedback: Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                height: GameConstants.handCardHeight,
                                child: Card(
                                  child: Image.asset(
                                    cardPath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            childWhenDragging: Container(),
                            onDragEnd: (details) {
                              if (details.wasAccepted) {
                                context.read<PlayerHandBloc>().add(
                                  RemoveCard(cardPath),
                                );
                              }
                            },
                            child: GestureDetector(
                              onTap: () => widget.onShowZoom(context, cardPath),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Card(
                                  child: Image.asset(
                                    cardPath,
                                    height: GameConstants.handCardHeight,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        onReorder: (oldIndex, newIndex) {
                          context.read<PlayerHandBloc>().add(
                            ReorderCards(oldIndex, newIndex),
                          );
                        },
                      ),
                    ),
            );
          },
          onWillAcceptWithDetails: (details) => details.data.isNotEmpty,
          onAcceptWithDetails: (details) {
            final cardPath = details.data;
            context.read<PlayerHandBloc>().add(
              AddCard(cardPath),
            );
          },
        );
      },
    );
  }
} 