import 'package:alchemy_tcg/core/validators/cell_validator.dart';
import 'package:alchemy_tcg/data/repositories/deck_repository_impl.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/board/bloc/board_event.dart';
import 'package:alchemy_tcg/presentation/features/card_pile/widgets/card_pile_bottom_sheet.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/card_deck_event.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_bloc.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_event.dart';
import 'package:alchemy_tcg/presentation/features/grid/widgets/deck_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/grid/widgets/graveyard_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/grid/widgets/playable_cell_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:alchemy_tcg/presentation/features/grid/widgets/default_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/grid/managers/default_grid_layout_manager.dart';
import 'package:alchemy_tcg/presentation/features/grid/managers/default_grid_scroll_manager.dart';
import 'package:alchemy_tcg/presentation/features/zoom/implementations/default_card_zoom_handler.dart';
import '../features/board/bloc/board_bloc.dart';
import '../features/deck/bloc/card_deck_bloc.dart';
import '../features/hand/bloc/player_hand_bloc.dart';

final getIt = GetIt.instance;

class GamePageDependencies {
  final BoardBloc boardBloc;
  final DeckBloc deckBloc;
  final PlayerHandBloc playerHandBloc;
  final GraveyardBloc graveyardBloc;
  final DefaultGridScrollManager scrollManager;
  final DefaultCardZoomHandler zoomHandler;
  final DefaultGridLayoutManager layoutManager;
  final DeckRepository deckRepository;
  final VoidCallback onDoubleTapDeck;
  final ValueChanged<String> onCardAddedDeck;
  final ValueChanged<int> onCardRemovedDeck;
  final VoidCallback onDoubleTapGraveyard;
  final ValueChanged<String> onCardAddedGraveyard;
  final ValueChanged<int> onCardRemovedGraveyard;
  final CellValidator validator;
  final ValueChanged<String> onCardAddedBoard;
  final ValueChanged<int> onCardRemovedBoard;

  GamePageDependencies._({
    required this.boardBloc,
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
    required this.onCardAddedBoard,
    required this.onCardRemovedBoard,
  });

  static GamePageDependencies initialize(BuildContext context) {
    final scrollManager = DefaultGridScrollManager();
    final zoomHandler = DefaultCardZoomHandler();
    final deckRepository = DeckRepositoryImpl();
    final graveyardBloc = getIt<GraveyardBloc>();
    final boardBloc = getIt<BoardBloc>();
    final deckBloc = getIt<DeckBloc>();
    final playerHandBloc = getIt<PlayerHandBloc>();
    final validator = CellValidator();


    onDoubleTapDeck() => showCardPileBottomSheet(context, "Cartas no Deck", deckBloc.state.cardImages);
    onCardAddedDeck(String cardPath) => deckBloc.add(AddCardDeck(cardPath: cardPath));
    onCardRemovedDeck(int index) => deckBloc.add(RemoveCardDeck(index:index));

    onDoubleTapGraveyard() => showCardPileBottomSheet(context, "Cartas no Cemitério", graveyardBloc.state.cardImages);
    onCardAddedGraveyard(String cardPath) => graveyardBloc.add(AddCardGraveyard(cardPath));
    onCardRemovedGraveyard(int index) => graveyardBloc.add(RemoveCardGraveyard(index));

    onCardAddedBoard(String cardPath) => boardBloc.add(AddCardBoard(cardPath: cardPath));
    onCardRemovedBoard(int index) => boardBloc.add(RemoveCardBoard(index: index));

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
        validatorBoard: validator, 
        onShowZoom: zoomHandler.showCardZoom, 
        onCardAddedBoard: onCardAddedBoard, 
        onCardRemovedBoard: onCardRemovedBoard,
      ),
    );

    final layoutManager = DefaultGridLayoutManager(
      scrollManager: scrollManager,
      cellBuilder: cellBuilder,
    );

    return GamePageDependencies._(
      boardBloc: boardBloc,
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
      onCardAddedBoard: onCardAddedBoard, 
      onCardRemovedBoard: onCardRemovedBoard,
    );
  }
}