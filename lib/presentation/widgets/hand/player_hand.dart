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
        final screenWidth = MediaQuery.of(context).size.width;
        const double cardWidth = 100.0; // Largura fixa das cartas
        const double minSpacing = 10.0; // Espaço mínimo entre cartas
        final int totalCards = state.cards.length;

        double spacing = minSpacing;

        if (totalCards > 1) {
          // Ajustar o espaçamento proporcionalmente para caberem na tela
          double availableWidth = screenWidth - cardWidth;
          spacing = availableWidth / (totalCards - 1);

          // Limitar o espaçamento mínimo para evitar cartas muito sobrepostas
          spacing = spacing.clamp(10.0, cardWidth * 0.6);
        }

        return DragTarget<String>(
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
                              left: index * spacing, // Aplica a sobreposição proporcional
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
                                    context.read<PlayerHandBloc>().add(
                                      RemoveCard(cardPath),
                                    );
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
            context.read<PlayerHandBloc>().add(AddCard(cardPath));
          },
        );
      },
    );
  }
}
