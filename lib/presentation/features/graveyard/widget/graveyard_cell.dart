import 'package:alchemy_tcg/presentation/features/graveyard/widget/graveyard_backgound.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/widget/graveyard_cell_draggable.dart';
import 'package:flutter/material.dart';

class GraveyardCell extends StatelessWidget {
  final double cellSize;
  final VoidCallback onDoubleTap;
  final void Function(String) onCardAdded;
  final void Function(int index) onCardRemoved;
  final List<String> cardImages;

  const GraveyardCell({
    super.key,
    required this.cellSize,
    required this.onDoubleTap,
    required this.onCardAdded,
    required this.onCardRemoved,
    required this.cardImages,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
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
                    onCardRemoved(index);
                  },
                ),
            ],
          );
        },
        onWillAcceptWithDetails: (details) => details.data.isNotEmpty,
        onAcceptWithDetails: (details) => onCardAdded(details.data),
      ),
    );
  }
}