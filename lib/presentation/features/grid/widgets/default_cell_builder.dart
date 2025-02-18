import 'package:alchemy_tcg/core/constants/game_constants.dart';
import 'package:alchemy_tcg/domain/interfaces/i_cell_builder.dart';
import 'package:flutter/material.dart';
import 'deck_cell_builder.dart';
import 'graveyard_cell_builder.dart';
import 'spell_trap_cell_builder.dart';

class DefaultCellBuilder implements ICellBuilder {
  final Map<String, ICellBuilder> _cellBuilders;

  DefaultCellBuilder({
    required DeckCellBuilder deckCellBuilder,
    required GraveyardCellBuilder graveyardCellBuilder,
    required SpellTrapCellBuilder spellTrapCellBuilder,
  }) : _cellBuilders = {
          'deck': deckCellBuilder,
          'graveyard': graveyardCellBuilder,
          'spell_trap': spellTrapCellBuilder,
        };

  @override
  Widget buildCell(double cellSize, int row, int col) {
    final cellType = GameConstants.getCellType(row, col);
    return _cellBuilders[cellType]?.buildCell(cellSize, row, col,) ??
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
        );
  }
}
