import 'package:flutter/material.dart';

class BoardCellOverlay extends StatelessWidget {
  final bool isValidPosition;
  final bool isDraggingOver;

  const BoardCellOverlay({
    Key? key,
    required this.isValidPosition,
    required this.isDraggingOver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isDraggingOver) return Container();

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isValidPosition ? Colors.green : Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
} 