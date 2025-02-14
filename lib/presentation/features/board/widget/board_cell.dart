import 'package:alchemy_tcg/presentation/features/board/widget/board_background.dart';
import 'package:flutter/material.dart';
import '../bloc/board_bloc.dart';
import '../bloc/board_event.dart';
import '../../../../core/validators/cell_validator.dart';
import 'board_cell_overlay.dart';
import 'board_cell_draggable.dart';

class BoardCell extends StatelessWidget {
  final int row;
  final int col;
  final double cellSize;
  final Function(BuildContext, String) onShowZoom;
  final BoardBloc boardBloc;
  final CellValidator validator;
  final void Function(String) onCardAdded;
  final void Function(int index) onCardRemoved;
  final List<String> cardImages;

  const BoardCell({
    super.key,
    required this.row,
    required this.col,
    required this.cellSize,
    required this.onShowZoom,
    required this.boardBloc, 
    required this.validator,
    required this.onCardAdded, 
    required this.onCardRemoved, 
    required this.cardImages,
  });

  @override
  Widget build(BuildContext context) {
    if (!validator.isCentralCell(row, col)) {
      return _buildEmptyCell();
    }

    return GestureDetector(
      onLongPress: cardImages.isNotEmpty
          ? () => onShowZoom(context, cardImages.last)
          : null,
      child: DragTarget<String>(
        builder: (context, candidateData, rejectedData) => Stack(
          children: [
            BoardBackground(),
            for (int i = 0; i < cardImages.length; i++)
              BoardCellDraggable(
                cellSize: cellSize,
                imagePath: cardImages[i], 
                index: i, 
                onDragEnd: (index) {
                  onCardRemoved(index);
                },
              ),
            BoardCellOverlay(
              isValidPosition: validator.isCentralCell(row, col),
              isDraggingOver: candidateData.isNotEmpty,
            ),
          ],
        ),
        onWillAcceptWithDetails: (details) =>
            validator.isCentralCell(row, col), 
            // && validator.canAcceptCard(details.data, boardState.boardCards[cardKey] ?? []),
        onAcceptWithDetails: (details) =>
            boardBloc.add(AddCardBoard(cardPath: details.data)),
      ),
    );
  }

  Widget _buildEmptyCell() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(128, 128, 128, 0.2)),
      ),
    );
  }
}