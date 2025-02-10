import 'package:alchemy_tcg/core/constants/game_constants.dart';
import 'package:alchemy_tcg/domain/interfaces/i_cell_builder.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/board/bloc/board_bloc.dart';
import 'package:alchemy_tcg/presentation/features/board/widget/board_cell.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/card_deck_bloc.dart';
import 'package:alchemy_tcg/presentation/features/deck/widget/deck_cell.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_bloc.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/widget/gaveyard_cell.dart';
import 'package:alchemy_tcg/presentation/features/grid/bloc/grid_board_bloc.dart';
import 'package:flutter/widgets.dart';

class DefaultCellBuilder implements ICellBuilder {
  final GraveyardBloc graveyardBloc;
  final Function(BuildContext, String) onShowZoom;
  final BoardBloc boardBloc;
  final GridBoardBloc gridBoardBloc;
  final DeckBloc deckBloc;
  final DeckRepository deckRepository;

  DefaultCellBuilder({
    required this.graveyardBloc,
    required this.onShowZoom,
    required this.boardBloc,
    required this.gridBoardBloc,
    required this.deckBloc,
    required this.deckRepository,
  });

  @override
  Widget buildCell(int row, int col, double cellSize,) {
    if (GameConstants.isDeckPosition(row, col)) {
      return DeckCell(
        cellSize: cellSize, 
        deckBloc: deckBloc, 
        deckRepository: deckRepository,
      );
    }

    if (GameConstants.isGraveyardPosition(row, col)) {
      return GraveyardCell(
        cellSize: cellSize,
        graveyardBloc: graveyardBloc,
      );
    }

    if (GameConstants.isPlayablePosition(row, col)) {
      return BoardCell(
        row: row,
        col: col,
        cellSize: cellSize,
        onCardRemoved: (_) {},
        onShowZoom: onShowZoom,
        boardBloc: boardBloc, 
        gridBoardBloc: gridBoardBloc,
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(128, 128, 128, 0.2)),
      ),
    );
  }
}