import 'package:alchemy_tcg/data/repositories/deck_repository_impl.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/grid/bloc/grid_board_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:alchemy_tcg/presentation/features/grid/widgets/default_cell_builder.dart';
import 'package:alchemy_tcg/presentation/features/grid/managers/default_grid_layout_manager.dart';
import 'package:alchemy_tcg/presentation/features/grid/managers/default_grid_scroll_manager.dart';
import 'package:alchemy_tcg/presentation/features/zoom/implementations/default_card_zoom_handler.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_bloc.dart';
import '../features/board/bloc/board_bloc.dart';
import '../features/deck/bloc/card_deck_bloc.dart';
import '../features/hand/bloc/player_hand_bloc.dart';

final getIt = GetIt.instance;

class GamePageDependencies {
  final BoardBloc boardBloc;
  final DeckBloc deckBloc;
  final GridBoardBloc gridBoardBloc;
  final PlayerHandBloc playerHandBloc;
  final GraveyardBloc graveyardBloc;
  final DefaultGridScrollManager scrollManager;
  final DefaultCardZoomHandler zoomHandler;
  final DefaultGridLayoutManager layoutManager;
  final DeckRepository deckRepository;

  GamePageDependencies._({
    required this.boardBloc,
    required this.deckBloc,
    required this.gridBoardBloc,
    required this.playerHandBloc,
    required this.graveyardBloc,
    required this.scrollManager,
    required this.zoomHandler,
    required this.layoutManager,
    required this.deckRepository,
  });

  static GamePageDependencies initialize() {
    final scrollManager = DefaultGridScrollManager();
    final zoomHandler = DefaultCardZoomHandler();
    final deckRepository = DeckRepositoryImpl();
    final graveyardBloc = getIt<GraveyardBloc>();
    final boardBloc = getIt<BoardBloc>();
    final deckBloc = getIt<DeckBloc>();
    final gridBoardBloc = getIt<GridBoardBloc>();
    final playerHandBloc = getIt<PlayerHandBloc>();

    final cellBuilder = DefaultCellBuilder(
      graveyardBloc: graveyardBloc,
      onShowZoom: zoomHandler.showCardZoom,
      boardBloc: boardBloc, 
      gridBoardBloc: gridBoardBloc, 
      deckBloc: deckBloc, 
      deckRepository: deckRepository,
    );

    final layoutManager = DefaultGridLayoutManager(
      scrollManager: scrollManager,
      cellBuilder: cellBuilder,
    );

    return GamePageDependencies._(
      boardBloc: boardBloc,
      deckBloc: deckBloc,
      gridBoardBloc: gridBoardBloc,
      playerHandBloc: playerHandBloc,
      graveyardBloc: graveyardBloc,
      scrollManager: scrollManager,
      zoomHandler: zoomHandler,
      layoutManager: layoutManager, 
      deckRepository: deckRepository,
    );
  }
}
