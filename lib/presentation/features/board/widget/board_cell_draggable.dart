import 'package:flutter/material.dart';

class BoardCellDraggable extends StatelessWidget {
  final String cardPath;
  final String? cardBelow;
  final double cellSize;
  final int row;
  final int col;
  final VoidCallback onRemove;
  final Function(BuildContext, String) onShowZoom;

  const BoardCellDraggable({
    super.key,
    required this.cardPath,
    required this.cardBelow,
    required this.cellSize,
    required this.row,
    required this.col,
    required this.onShowZoom,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onLongPress: () => onShowZoom(context, cardPath),
        child: Draggable<String>(
          data: cardPath,
          onDragCompleted: onRemove,
          feedback: _buildCardImage(cardPath),
          childWhenDragging: cardBelow != null ? _buildCardImage(cardBelow!) : Container(),
          child: _buildCardImage(cardPath),
        ),
      ),
    );
  }

  Widget _buildCardImage(String path) {
    return Image.asset(
      path,
      width: cellSize,
      height: cellSize,
      fit: BoxFit.contain,
    );
  }
}