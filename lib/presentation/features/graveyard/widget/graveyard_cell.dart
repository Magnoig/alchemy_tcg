import 'package:alchemy_tcg/presentation/features/graveyard/widget/graveyard_backgound.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/widget/graveyard_cell_draggable.dart';
import 'package:flutter/material.dart';

class GraveyardCell extends StatelessWidget {
  final double cellSize;
  final void Function(String cellId) onDoubleTap;
  final void Function(String cellId, String cardPath) onCardAdded;
  final void Function(String cellId, int index) onCardRemoved;
  final List<String> cardImages;
  final String cellId;

  const GraveyardCell({
    super.key,
    required this.cellSize,
    required this.onDoubleTap,
    required this.onCardAdded,
    required this.onCardRemoved,
    required this.cardImages,
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
              GraveyardBackground(),
              for (int i = 0; i < cardImages.length; i++)
                GraveyardCellDraggable(
                  imagePath: cardImages[i],
                  cellSize: cellSize,
                  index: i,
                  onDragEnd: (index) {
                    onCardRemoved(cellId, index);
                  },
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