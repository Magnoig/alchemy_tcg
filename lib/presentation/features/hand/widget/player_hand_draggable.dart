import 'package:alchemy_tcg/core/constants/game_constants.dart';
import 'package:flutter/material.dart';

class PlayerHandDraggable extends StatelessWidget {
  final String cardPath;
  final Function(bool) onDragEnd;
  final VoidCallback onTap;

  const PlayerHandDraggable({
    super.key,
    required this.cardPath,
    required this.onDragEnd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: cardPath,
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: GameConstants.handCardHeight,
          child: Card(child: Image.asset(cardPath, fit: BoxFit.cover)),
        ),
      ),
      childWhenDragging: Container(),
      onDragEnd: (details) => onDragEnd(details.wasAccepted),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: Image.asset(cardPath, height: GameConstants.handCardHeight, fit: BoxFit.cover),
        ),
      ),
    );
  }
}