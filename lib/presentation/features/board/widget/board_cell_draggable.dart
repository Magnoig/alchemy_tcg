import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/board_bloc.dart';
import '../bloc/board_event.dart';
import '../../grid/bloc/grid_board_bloc.dart';
import '../../grid/bloc/grid_board_event.dart';

class BoardCellDraggable extends StatelessWidget {
  final String cardPath;
  final String? cardBelow;
  final double cellSize;
  final int row;
  final int col;
  final Function(BuildContext, String) onShowZoom;
  final Function(String) onCardRemoved;

  const BoardCellDraggable({
    super.key,
    required this.cardPath,
    required this.cardBelow,
    required this.cellSize,
    required this.row,
    required this.col,
    required this.onShowZoom,
    required this.onCardRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onLongPress: () => onShowZoom(context, cardPath),
        child: Draggable<String>(
          data: cardPath,
          onDragStarted: () {
            context.read<GridBoardBloc>().add(StartDraggingCard(cardPath));
          },
          onDragCompleted: () {
            context.read<BoardBloc>().add(RemoveCard(row: row, col: col));
            onCardRemoved(cardPath);
            context.read<GridBoardBloc>().add(StopDraggingCard());
          },
          onDraggableCanceled: (_, __) { 
            context.read<GridBoardBloc>().add(StopDraggingCard());
          },
          feedback: Image.asset(
            cardPath,
            width: cellSize,
            height: cellSize,
            fit: BoxFit.contain,
          ),
          childWhenDragging: cardBelow != null
              ? Image.asset(
                  cardBelow!,
                  fit: BoxFit.contain,
                )
              : Center(child: Text('Central')),
          child: Image.asset(
            cardPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
} 