import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/card_grid/card_grid_bloc.dart';
import '../../blocs/card_grid/card_grid_state.dart';
import '../../blocs/card_grid/card_grid_event.dart';
import '../../blocs/board/board_bloc.dart';
import '../../blocs/board/board_state.dart';
import '../../blocs/board/board_event.dart';
import '../../../core/services/cell_validator.dart';
import 'board_cell_content.dart';
import 'board_cell_overlay.dart';
import 'board_cell_draggable.dart';

class BoardCell extends StatelessWidget {
  final int row;
  final int col;
  final double cellSize;
  final Function(String) onCardRemoved;
  final Function(BuildContext, String) onShowZoom;
  final CellValidator _validator = CellValidator();

  BoardCell({
    Key? key,
    required this.row,
    required this.col,
    required this.cellSize,
    required this.onCardRemoved,
    required this.onShowZoom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!_validator.isCentralCell(row, col)) {
      return Card(
        color: Colors.grey,
        child: Center(
          child: Text('Outer'),
        ),
      );
    }

    final gridRow = row - 1;
    final gridCol = col - 1;

    return BlocBuilder<BoardBloc, BoardState>(
      builder: (context, boardState) {
        final cardKey = '$row,$col';
        final cardInCell = boardState.getTopCard(cardKey);
        final cardBelow = boardState.getCardBelowTop(cardKey);

        return BlocBuilder<CardGridBloc, CardGridState>(
          builder: (context, gridState) {
            return DragTarget<String>(
              builder: (context, candidateData, rejectedData) {
                return MouseRegion(
                  onEnter: (_) => context.read<CardGridBloc>().add(
                    HoverOverCell(gridRow, gridCol),
                  ),
                  onExit: (_) => context.read<CardGridBloc>().add(
                    LeaveCell(gridRow, gridCol),
                  ),
                  child: Stack(
                    children: [
                      BoardCellContent(
                        cellState: gridState.cellStates[gridRow][gridCol],
                        cardPath: cardInCell,
                        cellSize: cellSize,
                      ),
                      if (cardInCell != null)
                        BoardCellDraggable(
                          cardPath: cardInCell,
                          cardBelow: cardBelow,
                          cellSize: cellSize,
                          row: row,
                          col: col,
                          onShowZoom: onShowZoom,
                          onCardRemoved: onCardRemoved,
                        ),
                      BoardCellOverlay(
                        isValidPosition: gridState.validPositions.contains('$gridRow,$gridCol'),
                        isDraggingOver: candidateData.isNotEmpty,
                      ),
                    ],
                  ),
                );
              },
              onWillAccept: (data) => data != null && 
                  gridState.validPositions.contains('$gridRow,$gridCol') &&
                  _validator.canAcceptCard(data!, boardState.boardCards[cardKey] ?? []),
              onAccept: (cardPath) {
                context.read<BoardBloc>().add(PlaceCard(
                  row: row,
                  col: col,
                  cardPath: cardPath,
                ));
              },
            );
          },
        );
      },
    );
  }
} 