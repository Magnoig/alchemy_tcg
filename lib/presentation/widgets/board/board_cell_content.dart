import 'package:flutter/material.dart';
import '../../blocs/card_grid/card_grid_state.dart';

class BoardCellContent extends StatelessWidget {
  final CellState cellState;
  final String? cardPath;
  final double cellSize;

  const BoardCellContent({
    super.key,
    required this.cellState,
    required this.cardPath,
    required this.cellSize,
  });

  Color _getCellColor(CellState state) {
    switch (state) {
      case CellState.empty:
        return Colors.blue;
      case CellState.valid:
        return Color.fromRGBO(0, 128, 0, 0.3);
      case CellState.invalid:
        return Color.fromRGBO(255, 0, 0, 0.3);
      case CellState.highlighted:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getCellColor(cellState),
      child: Center(
        child: cardPath == null
            ? Text('Central')
            : Container(),
      ),
    );
  }
} 