import 'package:alchemy_tcg/domain/interfaces/i_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/board/bloc/board_bloc.dart';
import 'package:alchemy_tcg/presentation/features/board/widget/board_cell.dart';
import 'package:flutter/material.dart';

class PlayableCellBuilder implements ICellBuilder {
  final BoardBloc boardBloc;
  final Function(BuildContext, String) onShowZoom;

  PlayableCellBuilder({
    required this.boardBloc,
    required this.onShowZoom,
  });

  @override
  Widget buildCell(double cellSize, int row, int col) {
    return BoardCell(
      row: row,
      col: col,
      cellSize: cellSize,
      onShowZoom: onShowZoom,
      boardBloc: boardBloc,
    );
  }
}
