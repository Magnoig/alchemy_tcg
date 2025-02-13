import 'package:flutter/material.dart';

class GraveyardCellDraggable extends StatelessWidget {
  final String imagePath;
  final double cellSize;
  final int index; 
  final void Function(int index) onDragEnd;

  const GraveyardCellDraggable({
    super.key, 
    required this.imagePath,
    required this.cellSize,
    required this.index, 
    required this.onDragEnd,
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
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      childWhenDragging: Container(),
      onDragEnd: (details) => onDragEnd(index),
      child: Card(
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}