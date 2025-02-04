import 'package:get_it/get_it.dart';
import '../../data/repositories/asset_card_repository.dart';
import '../../data/repositories/asset_card_hand.dart';
import '../../domain/repositories/card_repository.dart';
import '../../domain/repositories/card_hand.dart';
import '../../presentation/blocs/board/board_bloc.dart';
import '../../presentation/blocs/card_deck/card_deck_bloc.dart';
import '../../presentation/blocs/grid_board/grid_board_bloc.dart';
import '../../presentation/blocs/player_hand/player_hand_bloc.dart';
import '../../domain/repositories/card_board.dart';
import '../../data/repositories/asset_card_board.dart';


final getIt = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  getIt.registerLazySingleton<CardRepository>(() => AssetCardRepository());
  getIt.registerLazySingleton<CardHand>(() => AssetCardHand());
  getIt.registerLazySingleton<CardBoard>(() => AssetCardBoard());
  // BLoCs
  getIt.registerFactory(() => BoardBloc(getIt()));
  getIt.registerFactory(() => CardDeckBloc(getIt()));
  getIt.registerFactory(() => GridBoardBloc());
  getIt.registerFactory(() => PlayerHandBloc(getIt()));
} 