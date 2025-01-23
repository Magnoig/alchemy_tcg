import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_grid/card_grid_bloc.dart';
import '../bloc/card_grid/card_grid_state.dart';
import '../bloc/card_grid/card_grid_event.dart';
import '../bloc/board/board_bloc.dart';
import '../bloc/board/board_state.dart';
import '../bloc/board/board_event.dart';
import 'card_zoom.dart';

class BoardCell extends StatelessWidget {
  final int row;
  final int col;
  final double cellSize;
  final Function(String) onCardRemoved;
  final Function(BuildContext, String) onShowZoom;

  const BoardCell({
    Key? key,
    required this.row,
    required this.col,
    required this.cellSize,
    required this.onCardRemoved,
    required this.onShowZoom,
  }) : super(key: key);

  Color _getCellColor(CellState state) {
    switch (state) {
      case CellState.empty:
        return Colors.blue;
      case CellState.valid:
        return Colors.green.withOpacity(0.3);
      case CellState.invalid:
        return Colors.red.withOpacity(0.3);
      case CellState.highlighted:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Células centrais (5x5) e outras células do tabuleiro
    bool isCentral = row >= 1 && row <= 5 && col >= 1 && col <= 5;
    
    if (!isCentral) {
      return Card(
        color: Colors.grey,
        child: Center(
          child: Text('Outer'),
        ),
      );
    }

    // Ajusta os índices para o grid 5x5 central
    final gridRow = row - 1;
    final gridCol = col - 1;

    return BlocBuilder<BoardBloc, BoardState>(
      builder: (context, boardState) {
        final cardKey = '$row,$col';
        final cardInCell = boardState.getTopCard(cardKey);

        return BlocBuilder<CardGridBloc, CardGridState>(
          builder: (context, gridState) {
            return DragTarget<String>(
              builder: (context, candidateData, rejectedData) {
                return MouseRegion(
                  onEnter: (_) {
                    context.read<CardGridBloc>().add(
                      HoverOverCell(gridRow, gridCol),
                    );
                  },
                  onExit: (_) {
                    context.read<CardGridBloc>().add(
                      LeaveCell(gridRow, gridCol),
                    );
                  },
                  child: Stack(
                    children: [
                      Card(
                        color: _getCellColor(gridState.cellStates[gridRow][gridCol]),
                        child: Center(
                          child: cardInCell == null
                              ? Text('Central')
                              : Container(),
                        ),
                      ),
                      if (cardInCell != null)
                        Positioned.fill(
                          child: GestureDetector(
                            onLongPress: () => onShowZoom(context, cardInCell),
                            child: Draggable<String>(
                              data: cardInCell,
                              onDragCompleted: () {
                                context.read<BoardBloc>().add(RemoveCard(
                                  row: row,
                                  col: col,
                                ));
                                onCardRemoved(cardInCell);
                              },
                              feedback: Image.asset(
                                cardInCell,
                                width: cellSize,
                                height: cellSize,
                                fit: BoxFit.contain,
                              ),
                              childWhenDragging: boardState.getCardBelowTop(cardKey) != null
                                  ? Image.asset(
                                      'assets/images/card_verso.png',
                                      fit: BoxFit.contain,
                                    )
                                  : Container(),
                              child: Image.asset(
                                cardInCell,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      if (candidateData.isNotEmpty)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: gridState.validPositions.contains('$gridRow,$gridCol')
                                    ? Colors.green
                                    : Colors.red,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
              onWillAccept: (data) {
                return gridState.validPositions.contains('$gridRow,$gridCol');
              },
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