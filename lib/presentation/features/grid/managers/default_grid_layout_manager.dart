import 'package:alchemy_tcg/core/constants/game_constants.dart';
import 'package:alchemy_tcg/domain/interfaces/grid_layout_manager.dart';
import 'package:alchemy_tcg/domain/interfaces/i_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/grid/managers/grid_scroll_manager.dart';
import 'package:flutter/widgets.dart';

class DefaultGridLayoutManager implements GridLayoutManager {
  final GridScrollManager scrollManager;
  final ICellBuilder cellBuilder;

  DefaultGridLayoutManager({
    required this.scrollManager,
    required this.cellBuilder,
  });

  @override
  Widget buildGrid(double screenWidth) {
    final cellSize = screenWidth / GameConstants.gridCols;
    return GridView.builder(
      controller: scrollManager.controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: GameConstants.gridCols,
        childAspectRatio: GameConstants.cardAspectRatio,
      ),
      itemCount: GameConstants.gridRows * GameConstants.gridCols,
      itemBuilder: (context, index) {
        final row = index ~/ GameConstants.gridCols;
        final col = index % GameConstants.gridCols;
        return cellBuilder.buildCell(cellSize, row, col);
      },
    );
  }
}