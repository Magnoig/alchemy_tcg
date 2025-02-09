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
    final cellSize = screenWidth / GameConstants.gridSize;
    
    return GridView.builder(
      controller: scrollManager.controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: GameConstants.gridSize,
        childAspectRatio: GameConstants.cardAspectRatio,
      ),
      itemCount: GameConstants.gridSize * GameConstants.gridSize,
      itemBuilder: (context, index) {
        final row = index ~/ GameConstants.gridSize;
        final col = index % GameConstants.gridSize;
        return cellBuilder.buildCell(row, col, cellSize);
      },
    );
  }
}