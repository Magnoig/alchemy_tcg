import 'package:get_it/get_it.dart';
import '../../data/repositories/asset_card_repository.dart';
import '../../data/repositories/asset_card_hand.dart';
import '../../domain/repositories/card_repository.dart';
import '../../domain/repositories/card_hand.dart';
import '../../presentation/board/bloc/board_bloc.dart';
import '../../presentation/deck/bloc/card_deck_bloc.dart';
import '../../presentation/blocs/grid_board/grid_board_bloc.dart';
import '../../presentation/hand/bloc/player_hand_bloc.dart';
import '../../domain/repositories/card_board.dart';
import '../../data/repositories/asset_card_board.dart';
import '../../data/services/grid_board_service.dart';
import 'package:alchemy_tcg/presentation/blocs/grid_board/grid_board_state.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  getIt.registerLazySingleton<CardRepository>(() => AssetCardRepository());
  getIt.registerLazySingleton<CardHand>(() => AssetCardHand());
  getIt.registerLazySingleton<CardBoard>(() => AssetCardBoard());
  
  // Services
  getIt.registerLazySingleton<GridBoardService>(() => GridBoardService(
     cellStates: GridBoardState.initial().cellStates,
     validPositions: GridBoardState.initial().validPositions,
   ));
  // BLoCs
  getIt.registerFactory(() => BoardBloc(getIt()));
  getIt.registerFactory(() => CardDeckBloc(getIt()));
  getIt.registerFactory(() => GridBoardBloc(getIt()));
  getIt.registerFactory(() => PlayerHandBloc(getIt()));
}