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
  final CardDeckBloc cardDeckBloc;
  final GridBoardBloc gridBoardBloc;
  final PlayerHandBloc playerHandBloc;
  final GraveyardBloc graveyardBloc;
  final DefaultGridScrollManager scrollManager;
  final DefaultCardZoomHandler zoomHandler;
  final DefaultGridLayoutManager layoutManager;

  GamePageDependencies._({
    required this.boardBloc,
    required this.cardDeckBloc,
    required this.gridBoardBloc,
    required this.playerHandBloc,
    required this.graveyardBloc,
    required this.scrollManager,
    required this.zoomHandler,
    required this.layoutManager,
  });

  static GamePageDependencies initialize() {
    final scrollManager = DefaultGridScrollManager();
    final zoomHandler = DefaultCardZoomHandler();
    final graveyardBloc = getIt<GraveyardBloc>();
    final boardBloc = getIt<BoardBloc>();
    final cardDeckBloc = getIt<CardDeckBloc>();
    final gridBoardBloc = getIt<GridBoardBloc>();
    final playerHandBloc = getIt<PlayerHandBloc>();

    final cellBuilder = DefaultCellBuilder(
      graveyardBloc: graveyardBloc,
      onShowZoom: zoomHandler.showCardZoom,
      boardBloc: boardBloc,
    );

    final layoutManager = DefaultGridLayoutManager(
      scrollManager: scrollManager,
      cellBuilder: cellBuilder,
    );

    return GamePageDependencies._(
      boardBloc: boardBloc,
      cardDeckBloc: cardDeckBloc,
      gridBoardBloc: gridBoardBloc,
      playerHandBloc: playerHandBloc,
      graveyardBloc: graveyardBloc,
      scrollManager: scrollManager,
      zoomHandler: zoomHandler,
      layoutManager: layoutManager,
    );
  }
}
