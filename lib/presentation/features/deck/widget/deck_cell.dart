import 'package:alchemy_tcg/assets/image_paths.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/card_pile/widgets/card_pile_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/game_constants.dart';
import '../../../../core/theme/game_theme.dart';
import '../bloc/card_deck_bloc.dart';
import '../bloc/card_deck_event.dart';
import '../bloc/card_deck_state.dart';
import 'card_stack.dart';

class DeckCell extends StatelessWidget {
  final double cellSize;
  final DeckBloc deckBloc;
  final DeckRepository deckRepository;

  const DeckCell({
    super.key,
    required this.cellSize,
    required this.deckBloc,
    required this.deckRepository,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = cellSize * 0.9;
    final cardHeight = cardWidth / GameConstants.cardAspectRatio;

    return BlocBuilder<DeckBloc, DeckState>(
      builder: (context, state) {
        if (state.cardImages.isEmpty) {
          return Card(
            color: GameTheme.deckColor,
            child: const Center(
              child: Text('Empty'),
            ),
          );
        }

        return GestureDetector(
          onDoubleTap: () => showCardPileBottomSheet(context, "Cartas no Deck", state.cardImages),
          child: Draggable<String>(
            data: state.cardImages.last,
            feedback: Material(
              color: Colors.transparent,
              child: FutureBuilder<String?>(
                future: deckRepository.getCardBack(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: cellSize,
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
                    return Container();
                  } else {
                    return SizedBox(
                      height: cellSize,
                      child: Card(
                        child: Image.asset(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            childWhenDragging: CardStack(cardWidth: cardWidth, cardHeight: cardHeight, deckRepository: deckRepository,),
            onDragEnd: (details) {
              if (details.wasAccepted) {
                deckBloc.add(RemoveTopCard());
              }
            },
            child: CardStack(cardWidth: cardWidth, cardHeight: cardHeight, deckRepository: deckRepository,),
          ),
        );
      },
    );
  }
} 