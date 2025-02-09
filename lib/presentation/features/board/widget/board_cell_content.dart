import 'package:alchemy_tcg/presentation/features/grid/bloc/grid_board_state.dart';
import 'package:flutter/material.dart';

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
        return Colors.pink;
      case CellState.invalid:
        return Colors.red;
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