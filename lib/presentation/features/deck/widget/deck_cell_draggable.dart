import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
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
          child: Card(
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
      ),
      childWhenDragging: Container(),
      onDragEnd: (details) {
        if (details.wasAccepted) {
          onDragEnd(index);
        }
      },
      child: Card(
        child: FutureBuilder<String?>(
          future: deckRepository.getCardBack(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
              return Container();
            } else {
              return Image.asset(snapshot.data!, fit: BoxFit.contain);
            }
          },
        ),
      ),
    );
  }
}