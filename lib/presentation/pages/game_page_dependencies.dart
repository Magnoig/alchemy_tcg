import 'package:alchemy_tcg/core/validators/cell_validator.dart';
import 'package:alchemy_tcg/data/repositories/deck_repository_impl.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/deck_state_extension.dart';
import 'package:alchemy_tcg/presentation/features/spell_trap/bloc/spell_trap_event.dart';
import 'package:alchemy_tcg/presentation/features/card_pile/widgets/card_pile_bottom_sheet.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/deck_event.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_bloc.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_event.dart';
import 'package:alchemy_tcg/presentation/features/grid/widgets/deck_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/grid/widgets/graveyard_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/grid/widgets/spell_trap_cell_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:alchemy_tcg/presentation/features/grid/widgets/default_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/grid/managers/default_grid_layout_manager.dart';
import 'package:alchemy_tcg/presentation/features/grid/managers/default_grid_scroll_manager.dart';
import 'package:alchemy_tcg/presentation/features/zoom/implementations/default_card_zoom_handler.dart';
import '../features/spell_trap/bloc/spell_trap_bloc.dart';
import '../features/deck/bloc/deck_bloc.dart';
import '../features/hand/bloc/player_hand_bloc.dart';

final getIt = GetIt.instance;

class GamePageDependencies {
  final SpellTrapBloc spellTrapBloc;
  final DeckBloc deckBloc;
  final PlayerHandBloc playerHandBloc;
  final GraveyardBloc graveyardBloc;
  final DefaultGridScrollManager scrollManager;
  final DefaultCardZoomHandler zoomHandler;
  final DefaultGridLayoutManager layoutManager;
  final DeckRepository deckRepository;
  final void Function(String cellId) onDoubleTapDeck;
  final void Function(String cellId, String cardPath) onCardAddedDeck;
  final void Function(String cellId, int index) onCardRemovedDeck;
  final void Function(String cellId) onDoubleTapGraveyard;
  final void Function(String cellId, String cardPath) onCardAddedGraveyard;
  final void Function(String cellId, int index) onCardRemovedGraveyard;
  final CellValidator validator;
  final void Function(String cellId, String) onCardAddedSpellTrap;
  final void Function(String cellId, int) onCardRemovedSpellTrap;

  GamePageDependencies._({
    required this.spellTrapBloc,
    required this.deckBloc,
    required this.playerHandBloc,
    required this.graveyardBloc,
    required this.scrollManager,
    required this.zoomHandler,
    required this.layoutManager,
    required this.deckRepository,
    required this.onDoubleTapDeck,
    required this.onCardAddedDeck,
    required this.onCardRemovedDeck,
    required this.onDoubleTapGraveyard,
    required this.onCardAddedGraveyard,
    required this.onCardRemovedGraveyard,
    required this.validator,
    required this.onCardAddedSpellTrap,
    required this.onCardRemovedSpellTrap,
  });

  static GamePageDependencies initialize(BuildContext context) {
    final scrollManager = DefaultGridScrollManager();
    final zoomHandler = DefaultCardZoomHandler();
    final deckRepository = DeckRepositoryImpl();
    final graveyardBloc = getIt<GraveyardBloc>();
    final spellTrapBloc = getIt<SpellTrapBloc>();
    final deckBloc = getIt<DeckBloc>();
    final playerHandBloc = getIt<PlayerHandBloc>();
    final validator = CellValidator();


    onDoubleTapDeck(String cellId) => showCardPileBottomSheet(context, "Cartas no Deck", deckBloc.state.getCardsForCell(cellId));
    onCardAddedDeck(String cellId, String cardPath) => deckBloc.add(AddCardDeck(cellId: cellId, cardPath: cardPath));
    onCardRemovedDeck(String cellId, int index) => deckBloc.add(RemoveCardDeck(cellId: cellId, index: index));

    onDoubleTapGraveyard(String cellId) => showCardPileBottomSheet(context, "Cartas no Cemitério", graveyardBloc.state.graveyardCards[cellId] ?? []);
    onCardAddedGraveyard(String cellId, String cardPath) => graveyardBloc.add(AddCardGraveyard(cellId: cellId, cardPath: cardPath));
    onCardRemovedGraveyard(String cellId, int index) => graveyardBloc.add(RemoveCardGraveyard(cellId: cellId, index: index));

    onCardAddedSpellTrap(String cellId, String cardPath) =>
      spellTrapBloc.add(AddCardSpellTrap(cellId: cellId, cardPath: cardPath));
    onCardRemovedSpellTrap(String cellId, int index) =>
      spellTrapBloc.add(RemoveCardSpellTrap(cellId: cellId, index: index));

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
        spellTrapBloc: spellTrapBloc,
        validatorSpellTrap: validator, 
        onShowZoom: zoomHandler.showCardZoom, 
        onCardAddedSpellTrap: onCardAddedSpellTrap, 
        onCardRemovedSpellTrap: onCardRemovedSpellTrap,
      ),
    );

    final layoutManager = DefaultGridLayoutManager(
      scrollManager: scrollManager,
      cellBuilder: cellBuilder,
    );

    return GamePageDependencies._(
      spellTrapBloc: spellTrapBloc,
      deckBloc: deckBloc,
      playerHandBloc: playerHandBloc,
      graveyardBloc: graveyardBloc,
      scrollManager: scrollManager,
      zoomHandler: zoomHandler,
      layoutManager: layoutManager,
      deckRepository: deckRepository,
      onDoubleTapDeck: onDoubleTapDeck,
      onCardAddedDeck: onCardAddedDeck,
      onCardRemovedDeck: onCardRemovedDeck,
      onDoubleTapGraveyard: onDoubleTapGraveyard,
      onCardAddedGraveyard: onCardAddedGraveyard,
      onCardRemovedGraveyard: onCardRemovedGraveyard, 
      validator: validator, 
      onCardAddedSpellTrap: onCardAddedSpellTrap, 
      onCardRemovedSpellTrap: onCardRemovedSpellTrap,
    );
  }
}