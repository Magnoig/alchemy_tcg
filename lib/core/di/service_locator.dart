import 'package:get_it/get_it.dart';
import '../../data/repositories/asset_card_repository.dart';
import '../../data/repositories/asset_card_hand.dart';
import '../../domain/repositories/card_repository.dart';
import '../../domain/repositories/card_hand.dart';
import '../../presentation/blocs/board/board_bloc.dart';
import '../../presentation/blocs/card_deck/card_deck_bloc.dart';
import '../../presentation/blocs/card_grid/card_grid_bloc.dart';
import '../../presentation/blocs/player_hand/player_hand_bloc.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  getIt.registerLazySingleton<CardRepository>(() => AssetCardRepository());
  getIt.registerLazySingleton<CardHand>(() => AssetCardHand());

  // BLoCs
  getIt.registerFactory(() => BoardBloc());
  getIt.registerFactory(() => CardDeckBloc(getIt()));
  getIt.registerFactory(() => CardGridBloc());
  getIt.registerFactory(() => PlayerHandBloc(getIt()));
} 