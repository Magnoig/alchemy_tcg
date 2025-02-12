import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/board_bloc.dart';
import '../bloc/board_state.dart';
import '../bloc/board_event.dart';
import '../../../../core/validators/cell_validator.dart';
import 'board_cell_overlay.dart';
import 'board_cell_draggable.dart';

class BoardCell extends StatelessWidget {
  final int row;
  final int col;
  final double cellSize;
  final Function(String) onCardRemoved;
  final Function(BuildContext, String) onShowZoom;
  final BoardBloc boardBloc;
  final CellValidator validator = CellValidator();

  BoardCell({
    super.key,
    required this.row,
    required this.col,
    required this.cellSize,
    required this.onCardRemoved,
    required this.onShowZoom,
    required this.boardBloc,
  });

  @override
  Widget build(BuildContext context) {
    if (!validator.isCentralCell(row, col)) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(128, 128, 128, 0.2)),
        ),
      );
    }

    return BlocBuilder<BoardBloc, BoardState>(
      builder: (context, boardState) {
        final cardKey = '$row,$col';
        final cardInCell = boardState.getTopCard(cardKey);
        final cardBelow = boardState.getCardBelowTop(cardKey);

        return DragTarget<String>(
          builder: (context, candidateData, rejectedData) {
            return Stack(
              children: [
                if (cardInCell != null)
                  BoardCellDraggable(
                    cardPath: cardInCell,
                    cardBelow: cardBelow,
                    cellSize: cellSize,
                    row: row,
                    col: col,
                    onShowZoom: onShowZoom,
                    onCardRemoved: onCardRemoved,  
                    boardBloc: boardBloc,
                  ),
                BoardCellOverlay(
                  isValidPosition: validator.isCentralCell(row, col),
                  isDraggingOver: candidateData.isNotEmpty,
                ),
              ],
            );
          },
          onWillAcceptWithDetails: (details) =>
              validator.isCentralCell(row, col) &&
              validator.canAcceptCard(details.data, boardState.boardCards[cardKey] ?? []),
          onAcceptWithDetails: (details) {
            final cardPath = details.data;
            boardBloc.add(PlaceCard(
              row: row,
              col: col,
              cardPath: cardPath,
            ));
          },
        );
      },
    );
  }
} 