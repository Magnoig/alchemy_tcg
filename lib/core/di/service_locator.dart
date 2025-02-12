import 'package:alchemy_tcg/data/repositories/graveyard_repository_impl.dart.dart';
import 'package:alchemy_tcg/domain/repositories/graveyard_repository.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../data/repositories/deck_repository_impl.dart';
import '../../data/repositories/hand_repository_impl.dart';
import '../../domain/repositories/deck_repository.dart';
import '../../domain/repositories/hand_repository.dart';
import '../../presentation/features/board/bloc/board_bloc.dart';
import '../../presentation/features/deck/bloc/card_deck_bloc.dart';
import '../../presentation/features/hand/bloc/player_hand_bloc.dart';
import '../../domain/repositories/board_repository.dart';
import '../../data/repositories/board_repository_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  getIt.registerLazySingleton<DeckRepository>(() => DeckRepositoryImpl());
  getIt.registerLazySingleton<HandRepository>(() => HandRepositoryImpl());
  getIt.registerLazySingleton<BoardRepository>(() => BoardRepositoryImpl());
  getIt.registerLazySingleton<GraveyardRepository>(() => GraveyardRepositoryImpl());
  
  // BLoCs
  getIt.registerFactory(() => BoardBloc(getIt()));
  getIt.registerFactory(() => DeckBloc(getIt()));
  getIt.registerFactory(() => PlayerHandBloc(getIt()));
  getIt.registerFactory(() => GraveyardBloc(getIt()));
}