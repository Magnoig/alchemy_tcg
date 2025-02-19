import 'package:flutter/material.dart';

class SpellTrapCellDraggable extends StatelessWidget {
  final String imagePath;
  final double cellSize;
  final int index;
  final void Function(int index) onDragEnd;

  const SpellTrapCellDraggable({
    super.key,
    required this.imagePath,
    required this.cellSize,
    required this.index,
    required this.onDragEnd, 
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Draggable<String>(
        data: imagePath,
        feedback: _buildCardImage(imagePath),
        childWhenDragging: Container(),
        onDragEnd: (details) => onDragEnd(index),
        child: _buildCardImage(imagePath),
      ),
    );
  }

  Widget _buildCardImage(String path) {
    return Image.asset(
      path,
      width: cellSize,
      height: cellSize,
    );
  }
}