import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:flutter/material.dart';

class DeckCellDraggable extends StatefulWidget {
  final String imagePath;
  final double cellSize;
  final int index;
  final void Function(int index) onDragEnd;
  final DeckRepository deckRepository;

  const DeckCellDraggable({
    super.key,
    required this.imagePath,
    required this.cellSize,
    required this.index,
    required this.onDragEnd,
    required this.deckRepository,
  });

  @override
  _DeckCellDraggableState createState() => _DeckCellDraggableState();
}

class _DeckCellDraggableState extends State<DeckCellDraggable> {
  bool isCardFaceDown = true;  // Inicialmente a carta está virada para baixo

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: widget.imagePath,
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: widget.cellSize,
          child: Card(
            child: isCardFaceDown
                ? FutureBuilder<String?>(
                    future: widget.deckRepository.getCardBack(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: widget.cellSize,
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
                        return Container();
                      } else {
                        return Image.asset(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  )
                : Image.asset(
                    widget.imagePath,
                    fit: BoxFit.contain,
                  ),
          ),
        ),
      ),
      childWhenDragging: Container(),
      onDragEnd: (details) {
        widget.onDragEnd(widget.index);
        // A carta deve virar para cima somente após o drag terminar
        if (details.wasAccepted) {
          setState(() {
            isCardFaceDown = false; // A carta virando para cima
          });
        }
      },
      child: Card(
        child: isCardFaceDown
            ? FutureBuilder<String?>(
                future: widget.deckRepository.getCardBack(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
                    return Container();
                  } else {
                    return Image.asset(
                      snapshot.data!,
                      fit: BoxFit.contain,
                    );
                  }
                },
              )
            : Image.asset(
                widget.imagePath,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}