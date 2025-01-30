import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/board/board_bloc.dart';
import '../../blocs/board/board_event.dart';
import '../../blocs/card_grid/card_grid_bloc.dart';
import '../../blocs/card_grid/card_grid_event.dart';

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
            context.read<CardGridBloc>().add(StartDraggingCard(cardPath));
          },
          onDragCompleted: () {
            context.read<BoardBloc>().add(RemoveCard(row: row, col: col));
            onCardRemoved(cardPath);
            context.read<CardGridBloc>().add(StopDraggingCard());
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
              : Container(),
          child: Image.asset(
            cardPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
} 