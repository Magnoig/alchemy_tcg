import 'package:alchemy_tcg/domain/interfaces/i_cell_builder.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/card_deck_bloc.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/card_deck_state.dart';
import 'package:alchemy_tcg/presentation/features/deck/widget/deck_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeckCellBuilder implements ICellBuilder {
  final DeckBloc deckBloc;
  final DeckRepository deckRepository;
  final VoidCallback onDoubleTapDeck;
  final void Function(String) onCardAddedDeck;
  final void Function(int) onCardRemovedDeck;

  DeckCellBuilder({
    required this.deckBloc,
    required this.deckRepository,
    required this.onDoubleTapDeck,
    required this.onCardAddedDeck,
    required this.onCardRemovedDeck,
  });

  @override
  Widget buildCell(double cellSize, int row, int col) {
    return BlocBuilder<DeckBloc, DeckState>(
      builder: (context, state) {
        return DeckCell(
          cellSize: cellSize,
          deckRepository: deckRepository,
          onDoubleTap: onDoubleTapDeck,
          onCardAdded: onCardAddedDeck,
          onCardRemoved: onCardRemovedDeck,
          cardImages: state.cardImages,
        );
      },
    );
  }
}
