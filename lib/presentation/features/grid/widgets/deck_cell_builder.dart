import 'package:alchemy_tcg/domain/interfaces/i_cell_builder.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/deck_bloc.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/deck_event.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/deck_state.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/deck_state_extension.dart';
import 'package:alchemy_tcg/presentation/features/deck/widget/deck_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeckCellBuilder implements ICellBuilder {
  final DeckBloc deckBloc;
  final DeckRepository deckRepository;
  final void Function(String cellId) onDoubleTapDeck;
  final void Function(String cellId, String cardPath) onCardAddedDeck;
  final void Function(String cellId, int index) onCardRemovedDeck;

  DeckCellBuilder({
    required this.deckBloc,
    required this.deckRepository,
    required this.onDoubleTapDeck,
    required this.onCardAddedDeck,
    required this.onCardRemovedDeck,
  });

  @override
  Widget buildCell(double cellSize, int row, int col) {
    String cellId = '$row-$col';

    if (deckBloc.state.getCardsForCell(cellId).isEmpty) {
      deckBloc.add(InitializeDeck(cellId: cellId));
    }
    
    return BlocBuilder<DeckBloc, DeckState>(
      builder: (context, state) {
        return DeckCell(
          cellSize: cellSize,
          deckRepository: deckRepository,
          onDoubleTap: onDoubleTapDeck,
          onCardAdded: onCardAddedDeck,
          onCardRemoved: onCardRemovedDeck,
          cellId: cellId,
          cardImages: state.getCardsForCell(cellId),
        );
      },
    );
  }
}
