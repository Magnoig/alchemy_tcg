import 'package:alchemy_tcg/presentation/features/card_pile/widgets/card_pile_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/game_constants.dart';
import '../../../../core/theme/game_theme.dart';
import '../bloc/player_hand_bloc.dart';
import '../bloc/player_hand_event.dart';
import '../bloc/player_hand_state.dart';

class PlayerHand extends StatefulWidget {
  final Function(BuildContext, String) onShowZoom;
  final PlayerHandBloc playerHandBloc;

  const PlayerHand({
    super.key,
    required this.onShowZoom,
    required this.playerHandBloc,
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
      bloc: widget.playerHandBloc,
      builder: (context, state) {
        final screenWidth = MediaQuery.of(context).size.width;
        const double cardWidth = 100.0;
        const double minSpacing = 10.0;
        final int totalCards = state.cards.length;

        double spacing = minSpacing;

        if (totalCards > 1) {
          double availableWidth = screenWidth - cardWidth;
          spacing = availableWidth / (totalCards - 1);
          spacing = spacing.clamp(10.0, cardWidth * 0.6);
        }

        return GestureDetector(
          onDoubleTap: () => showCardPileBottomSheet(context, "Cartas na Mão", state.cards),
          child: DragTarget<String>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                height: GameConstants.handHeight,
                color: GameTheme.handBackgroundColor,
                child: state.cards.isEmpty
                    ? const Center(child: Text('Empty Hand'))
                    : GestureDetector(
                        onHorizontalDragUpdate: _handleHorizontalDragUpdate,
                        child: SizedBox(
                          width: screenWidth,
                          child: Stack(
                            children: List.generate(state.cards.length, (index) {
                              final cardPath = state.cards[index];
          
                              return Positioned(
                                left: index * spacing,
                                child: Draggable<String>(
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
                                      widget.playerHandBloc.add(RemoveCard(cardPath));
                                    }
                                  },
                                  child: GestureDetector(
                                    onTap: () => widget.onShowZoom(context, cardPath),
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
                            }),
                          ),
                        ),
                      ),
              );
            },
            onWillAcceptWithDetails: (details) => details.data.isNotEmpty,
            onAcceptWithDetails: (details) {
              final cardPath = details.data;
              widget.playerHandBloc.add(AddCard(cardPath));
            },
          ),
        );
      },
    );
  }
}