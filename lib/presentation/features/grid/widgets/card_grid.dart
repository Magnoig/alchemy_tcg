import 'package:alchemy_tcg/core/validators/cell_validator.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/spell_trap/bloc/spell_trap_bloc.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/deck_bloc.dart';
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
import 'spell_trap_cell_builder.dart';

class CardGrid extends StatelessWidget {

  final PlayerHandBloc playerHandBloc;
  final VoidCallback onDoubleTap;
  final void Function(String) onCardAdded;
  final void Function(int) onCardRemoved;

  final DeckRepository deckRepository;
  final DeckBloc deckBloc;
  final void Function(String cellId) onDoubleTapDeck;
  final void Function(String cellId, String cardPath) onCardAddedDeck;
  final void Function(String cellId, int index) onCardRemovedDeck;

  final GraveyardBloc graveyardBloc;
  final void Function(String cellId) onDoubleTapGraveyard;
  final void Function(String cellId, String cardPath) onCardAddedGraveyard;
  final void Function(String cellId, int index) onCardRemovedGraveyard;

  final SpellTrapBloc boardBloc;
  final Function(BuildContext, String) onShowZoom;
  final CellValidator validatorSpellTrap;
  final void Function(String cellId, String) onCardAddedSpellTrap;
  final void Function(String cellId, int) onCardRemovedSpellTrap;

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
    required this.validatorSpellTrap,
    required this.onCardAddedSpellTrap, 
    required this.onCardRemovedSpellTrap, 

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
      spellTrapCellBuilder: SpellTrapCellBuilder(
        spellTrapBloc: boardBloc, 
        validatorSpellTrap: validatorSpellTrap, 
        onShowZoom: onShowZoom, 
        onCardAddedSpellTrap: onCardAddedSpellTrap, 
        onCardRemovedSpellTrap: onCardRemovedSpellTrap, 
        
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