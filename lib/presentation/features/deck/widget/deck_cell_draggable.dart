import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/deck/widget/deck_card_back.dart';
import 'package:flutter/material.dart';

class DeckCellDraggable extends StatelessWidget {
  final int index;
  final double cellSize;
  final DeckRepository deckRepository;
  final void Function(int index) onDragEnd;
  final String imagePath;

  const DeckCellDraggable({
    super.key,
    required this.index,
    required this.cellSize,
    required this.onDragEnd,
    required this.deckRepository,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {

    return Draggable<String>(
      data: imagePath,
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: cellSize,
          child: DeckCardBack(deckRepository: deckRepository,),
        ),
      ),
      childWhenDragging: Container(),
      onDragEnd: (details) {
        if (details.wasAccepted) {
          onDragEnd(index);
        }
      },
      child:  DeckCardBack(deckRepository: deckRepository,),
    );
  }
}