import 'package:alchemy_tcg/data/repositories/deck_repository_impl.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/card_pile/widgets/card_pile_bottom_sheet.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_bloc.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_event.dart';
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

  GamePageDependencies._({
    required this.boardBloc,
    required this.deckBloc,
    required this.playerHandBloc,
    required this.graveyardBloc,
    required this.scrollManager,
    required this.zoomHandler,
    required this.layoutManager,
    required this.deckRepository,
  });

  static GamePageDependencies initialize(BuildContext context) {
    final scrollManager = DefaultGridScrollManager();
    final zoomHandler = DefaultCardZoomHandler();
    final deckRepository = DeckRepositoryImpl();
    final graveyardBloc = getIt<GraveyardBloc>();
    final boardBloc = getIt<BoardBloc>();
    final deckBloc = getIt<DeckBloc>();
    final playerHandBloc = getIt<PlayerHandBloc>();

    final cellBuilder = DefaultCellBuilder(
      graveyardBloc: graveyardBloc,
      onShowZoom: zoomHandler.showCardZoom,
      boardBloc: boardBloc,  
      deckBloc: deckBloc, 
      deckRepository: deckRepository, 
      onGraveyardDoubleTap: () => showCardPileBottomSheet(context, "Cartas no Cemitério", graveyardBloc.state.cardImages), 
      onGraveyardCardAdded: (cardPath) => graveyardBloc.add(AddCardGraveyard(cardPath)), 
      onGraveyardCardRemoved: (index) => graveyardBloc.add(RemoveCardGraveyard(index)), 
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
    );
  }
}
