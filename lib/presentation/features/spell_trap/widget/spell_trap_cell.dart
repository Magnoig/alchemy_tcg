import 'package:alchemy_tcg/presentation/features/spell_trap/widget/spell_trap_background.dart';
import 'package:flutter/material.dart';
import '../bloc/spell_trap_bloc.dart';
import '../../../../core/validators/cell_validator.dart';
import 'board_cell_overlay.dart';
import 'spell_trap_cell_draggable.dart';

class SpellTrapCell extends StatelessWidget {
  final int row;
  final int col;
  final double cellSize;
  final Function(BuildContext, String) onShowZoom;
  final SpellTrapBloc spellTrapBloc;
  final CellValidator validator;
  final void Function(String cellId, String cardPath) onCardAdded;
  final void Function(String cellId, int index) onCardRemoved;
  final List<String> cardImages;
  final String cellId;  // Adicionei o cellId

  const SpellTrapCell({
    super.key,
    required this.row,
    required this.col,
    required this.cellSize,
    required this.onShowZoom,
    required this.spellTrapBloc,
    required this.validator,
    required this.onCardAdded,
    required this.onCardRemoved,
    required this.cardImages,
    required this.cellId, // Adicionado
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
              SpellTrapCellDraggable(
                cellSize: cellSize,
                imagePath: cardImages[i],
                index: i,
                onDragEnd: (index) {
                  onCardRemoved(cellId, index); // Agora passando cellId
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
        onAcceptWithDetails: (details) => onCardAdded(cellId, details.data), // Agora passando cellId
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
