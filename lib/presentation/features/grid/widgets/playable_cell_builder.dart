import 'package:alchemy_tcg/core/validators/cell_validator.dart';
import 'package:alchemy_tcg/domain/interfaces/i_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/board/bloc/board_bloc.dart';
import 'package:alchemy_tcg/presentation/features/board/bloc/board_state.dart';
import 'package:alchemy_tcg/presentation/features/board/widget/board_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayableCellBuilder implements ICellBuilder {
  final BoardBloc boardBloc;
  final Function(BuildContext, String) onShowZoom;
  final CellValidator validatorBoard;
  final void Function(String) onCardAddedBoard;
  final void Function(int index) onCardRemovedBoard;

  PlayableCellBuilder({
    required this.boardBloc,
    required this.onShowZoom,
    required this.validatorBoard,
    required this.onCardAddedBoard, 
    required this.onCardRemovedBoard, 
  });

  @override
  Widget buildCell(double cellSize, int row, int col) {
    return BlocBuilder<BoardBloc, BoardState>(
      bloc: boardBloc,
      builder: (context, state) {
        return BoardCell(
          row: row,
          col: col,
          cellSize: cellSize,
          onShowZoom: onShowZoom,
          boardBloc: boardBloc, 
          validator: validatorBoard,  
          onCardAdded: onCardAddedBoard, 
          onCardRemoved: onCardRemovedBoard, 
          cardImages: state.cardImages,
        );
      }
    );
  }
}
