import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/board/bloc/board_bloc.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/card_deck_bloc.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_bloc.dart';
import 'package:alchemy_tcg/presentation/features/grid/managers/default_grid_layout_manager.dart';
import 'package:alchemy_tcg/presentation/features/grid/managers/grid_scroll_manager.dart';
import 'package:alchemy_tcg/presentation/features/hand/bloc/player_hand_bloc.dart';
import 'package:alchemy_tcg/presentation/features/hand/bloc/player_hand_state.dart';
import 'package:alchemy_tcg/presentation/features/hand/widget/player_hand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'default_cell_builder.dart';
import 'deck_cell_builder.dart';
import 'graveyard_cell_builder.dart';
import 'playable_cell_builder.dart';

class CardGrid extends StatelessWidget {

  final PlayerHandBloc playerHandBloc;
  final VoidCallback onDoubleTap;
  final void Function(String) onCardAdded;
  final void Function(int) onCardRemoved;

  final DeckRepository deckRepository;
  final DeckBloc deckBloc;
  final VoidCallback onDoubleTapDeck;
  final void Function(String) onCardAddedDeck;
  final void Function(int) onCardRemovedDeck;

  final GraveyardBloc graveyardBloc;
  final VoidCallback onDoubleTapGraveyard;
  final void Function(String) onCardAddedGraveyard;
  final void Function(int) onCardRemovedGraveyard;

  final BoardBloc boardBloc;
  final Function(BuildContext, String) onShowZoom;

  const CardGrid({
    super.key,

    required this.playerHandBloc,
    required this.onDoubleTap,
    required this.onCardAdded,
    required this.onCardRemoved,

    required this.deckRepository,
    required this.deckBloc,
    required this.onDoubleTapDeck,
    required this.onCardAddedDeck,
    required this.onCardRemovedDeck,

    required this.graveyardBloc,
    required this.onDoubleTapGraveyard,
    required this.onCardAddedGraveyard,
    required this.onCardRemovedGraveyard,

    required this.boardBloc,
    required this.onShowZoom,
  });

  @override
  Widget build(BuildContext context) {
    final scrollManager = GridScrollManager();

    final cellBuilder = DefaultCellBuilder(
      deckCellBuilder: DeckCellBuilder(
        deckBloc: deckBloc,
        deckRepository: deckRepository,
        onDoubleTapDeck: onDoubleTapDeck,
        onCardAddedDeck: onCardAddedDeck,
        onCardRemovedDeck: onCardRemovedDeck,
      ),
      graveyardCellBuilder: GraveyardCellBuilder(
        graveyardBloc: graveyardBloc,
        onDoubleTapGraveyard: onDoubleTapGraveyard,
        onCardAddedGraveyard: onCardAddedGraveyard,
        onCardRemovedGraveyard: onCardRemovedGraveyard,
      ),
      playableCellBuilder: PlayableCellBuilder(
        boardBloc: boardBloc,
        onShowZoom: onShowZoom,
      ),
    );

    final layoutManager = DefaultGridLayoutManager(
      scrollManager: scrollManager,
      cellBuilder: cellBuilder,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('TCG')),
      body: Column(
        children: [
          
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return layoutManager.buildGrid(constraints.maxWidth);
              },
            ),
          ),

          BlocBuilder<PlayerHandBloc, PlayerHandState>(
            bloc: playerHandBloc,
            builder: (context, state) {
              return PlayerHand(
                onShowZoom: (context, cardId) => onShowZoom(context, cardId),
                cardImages: state.cards,
                onDoubleTap: onDoubleTap,
                onCardAdded: onCardAdded,
                onCardRemoved: onCardRemoved,
              );
            },
          ),
        ],
      ),
    );
  }
}