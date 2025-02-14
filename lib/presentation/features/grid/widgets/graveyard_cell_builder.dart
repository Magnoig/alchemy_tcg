import 'package:alchemy_tcg/domain/interfaces/i_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_bloc.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_state.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/widget/gaveyard_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraveyardCellBuilder implements ICellBuilder {
  final GraveyardBloc graveyardBloc;
  final VoidCallback onDoubleTapGraveyard;
  final void Function(String) onCardAddedGraveyard;
  final void Function(int) onCardRemovedGraveyard;

  GraveyardCellBuilder({
    required this.graveyardBloc,
    required this.onDoubleTapGraveyard,
    required this.onCardAddedGraveyard,
    required this.onCardRemovedGraveyard,
  });

  @override
  Widget buildCell(double cellSize, int row, int col,) {
    return BlocBuilder<GraveyardBloc, GraveyardState>(
      bloc: graveyardBloc,
      builder: (context, state) {
        return GraveyardCell(
          cellSize: cellSize,
          onDoubleTap: onDoubleTapGraveyard,
          onCardAdded: onCardAddedGraveyard,
          onCardRemoved: onCardRemovedGraveyard,
          cardImages: state.cardImages,
        );
      },
    );
  }
}