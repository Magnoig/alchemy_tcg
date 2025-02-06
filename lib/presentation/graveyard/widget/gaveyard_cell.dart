import 'package:alchemy_tcg/core/constants/game_constants.dart';
import 'package:alchemy_tcg/core/theme/game_theme.dart';
import 'package:alchemy_tcg/presentation/graveyard/bloc/graveyard_bloc.dart';
import 'package:alchemy_tcg/presentation/graveyard/bloc/graveyard_event.dart';
import 'package:alchemy_tcg/presentation/graveyard/bloc/graveyard_state.dart';
import 'package:alchemy_tcg/presentation/widgets/card_pile_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraveyardCell extends StatelessWidget {
  final double cellSize;

  const GraveyardCell({super.key, required this.cellSize});

  @override
  Widget build(BuildContext context) {
    final cardWidth = cellSize * 0.9;
    final cardHeight = cardWidth / GameConstants.cardAspectRatio;

    return BlocBuilder<GraveyardBloc, GraveyardState>(
      builder: (context, state) {
        return GestureDetector(
          onDoubleTap: () => showCardPileBottomSheet(context, "Cartas no Cemitério", state.cardImages),
          child: DragTarget<String>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: cardWidth,
                height: cardHeight,
                decoration: BoxDecoration(
                  color: GameTheme.graveyardColor,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: state.cardImages.isEmpty
                    ? const Center(child: Text('Graveyard Empty'))
                    : Draggable<String>(
                        data: state.cardImages.last, // Última carta do graveyard
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
                        childWhenDragging: state.cardImages.length > 1
                            ? Card(
                                child: Image.asset(
                                  state.cardImages[state.cardImages.length - 2],
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(),
                        onDragEnd: (details) {
                          if (details.wasAccepted) {
                            context.read<GraveyardBloc>().add(RemoveTopCardGraveyard());
                          }
                        },
                        child: Card(
                          child: Image.asset(
                            state.cardImages.last,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              );
            },
            onWillAcceptWithDetails: (details) {
              return details.data.isNotEmpty;
            },
            onAcceptWithDetails: (details) {
              final cardPath = details.data;
              context.read<GraveyardBloc>().add(AddCardToGraveyard(cardPath));
            },
          ),
        );
      },
    );
  }
}