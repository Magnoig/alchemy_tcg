import 'package:alchemy_tcg/core/constants/game_constants.dart';
import 'package:alchemy_tcg/domain/interfaces/i_cell_builder.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/board/bloc/board_bloc.dart';
import 'package:alchemy_tcg/presentation/features/board/widget/board_cell.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/card_deck_bloc.dart';
import 'package:alchemy_tcg/presentation/features/deck/widget/deck_cell.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_bloc.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_state.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/widget/gaveyard_cell.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef CellBuilderFunction = Widget Function(double cellSize, int row, int col);

class DefaultCellBuilder implements ICellBuilder {
  final Map<String, CellBuilderFunction> _cellBuilders;

  DefaultCellBuilder({
    required GraveyardBloc graveyardBloc,
    required Function(BuildContext, String) onShowZoom,
    required BoardBloc boardBloc,
    required DeckBloc deckBloc,
    required DeckRepository deckRepository,
    required VoidCallback onGraveyardDoubleTap,
    required void Function(String) onGraveyardCardAdded,
    required void Function(int index) onGraveyardCardRemoved,
  }) : _cellBuilders = {
          'deck': (cellSize, row, col) => DeckCell(
                cellSize: cellSize,
                deckBloc: deckBloc,
                deckRepository: deckRepository,
              ),
          'graveyard': (cellSize, rol, col) => BlocBuilder<GraveyardBloc, GraveyardState>(
                builder: (context, state) {
                  return GraveyardCell(
                    cellSize: cellSize,
                    onDoubleTap: onGraveyardDoubleTap,
                    onCardAdded: onGraveyardCardAdded,
                    onCardRemoved: onGraveyardCardRemoved,
                    cardImages: state.cardImages,
                  );
                },
              ),
          'playable': (cellSize, row, col) => BoardCell(
                row: row,
                col: col,
                cellSize: cellSize,
                onShowZoom: onShowZoom,
                boardBloc: boardBloc,
              ),
        };

  @override
  Widget buildCell(int row, int col, double cellSize) {
    if (GameConstants.isDeckPosition(row, col)) return _cellBuilders['deck']!(cellSize, row, col);
    if (GameConstants.isGraveyardPosition(row, col)) return _cellBuilders['graveyard']!(cellSize, row, col);
    if (GameConstants.isPlayablePosition(row, col)) return _cellBuilders['playable']!(cellSize, row, col);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(128, 128, 128, 0.2)),
      ),
    );
  }
}