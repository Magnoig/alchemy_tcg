import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/deck/widget/deck_background.dart';
import 'package:alchemy_tcg/presentation/features/deck/widget/deck_cell_draggable.dart';
import 'package:flutter/material.dart';

class DeckCell extends StatelessWidget {
  final double cellSize;
  final void Function(String cellId) onDoubleTap;
  final void Function(String cellId, String cardPath) onCardAdded;
  final void Function(String cellId, int index) onCardRemoved;
  final List<String> cardImages;
  final DeckRepository deckRepository;
  final String cellId;

  const DeckCell({
    super.key,
    required this.cellSize,
    required this.onDoubleTap,
    required this.onCardAdded,
    required this.onCardRemoved,
    required this.cardImages,
    required this.deckRepository,
    required this.cellId,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onDoubleTap: () => onDoubleTap(cellId),
      child: DragTarget<String>(
        builder: (context, candidateData, rejectedData) {
          return Stack(
            children: [
              DeckBackground(),
              for (int i = 0; i < cardImages.length; i++)
                DeckCellDraggable(
                  imagePath: cardImages[i],
                  cellSize: cellSize,
                  index: i,
                  onDragEnd: (index) {
                    onCardRemoved(cellId, index);
                  },
                  deckRepository: deckRepository,
                ),
            ],
          );
        },
        onWillAcceptWithDetails: (details) => details.data.isNotEmpty,
        onAcceptWithDetails: (details) => onCardAdded(cellId, details.data),
      ),
    );
  }
}