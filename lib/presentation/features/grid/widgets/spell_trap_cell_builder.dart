import 'package:alchemy_tcg/core/validators/cell_validator.dart';
import 'package:alchemy_tcg/domain/interfaces/i_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/spell_trap/bloc/spell_trap_bloc.dart';
import 'package:alchemy_tcg/presentation/features/spell_trap/bloc/spell_trap_state.dart';
import 'package:alchemy_tcg/presentation/features/spell_trap/widget/spell_trap_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpellTrapCellBuilder implements ICellBuilder {
  final SpellTrapBloc spellTrapBloc;
  final Function(BuildContext, String) onShowZoom;
  final CellValidator validatorSpellTrap;
  final void Function(String) onCardAddedSpellTrap;
  final void Function(int index) onCardRemovedSpellTrap;

  SpellTrapCellBuilder({
    required this.spellTrapBloc,
    required this.onShowZoom,
    required this.validatorSpellTrap,
    required this.onCardAddedSpellTrap, 
    required this.onCardRemovedSpellTrap, 
  });

  @override
  Widget buildCell(double cellSize, int row, int col) {
    return BlocBuilder<SpellTrapBloc, SpellTrapState>(
      bloc: spellTrapBloc,
      builder: (context, state) {
        return SpellTrapCell(
          row: row,
          col: col,
          cellSize: cellSize,
          onShowZoom: onShowZoom,
          spellTrapBloc: spellTrapBloc, 
          validator: validatorSpellTrap,  
          onCardAdded: onCardAddedSpellTrap, 
          onCardRemoved: onCardRemovedSpellTrap, 
          cardImages: state.cardImages,
        );
      }
    );
  }
}
