import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:alchemy_tcg/core/di/service_locator.dart';
import 'package:alchemy_tcg/data/repositories/deck_repository_impl.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:alchemy_tcg/presentation/features/board/bloc/board_bloc.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/card_deck_bloc.dart';
import 'package:alchemy_tcg/presentation/features/grid/bloc/grid_board_bloc.dart';
import 'package:alchemy_tcg/presentation/features/hand/bloc/player_hand_bloc.dart';
import 'package:alchemy_tcg/domain/repositories/hand_repository.dart';
import 'package:alchemy_tcg/data/repositories/hand_repository_impl.dart';

void main() {
  setUp(() {
    // Limpa o service locator antes de cada teste
    GetIt.I.reset();
  });

  test('Service Locator registers CardRepository', () {
    setupServiceLocator();
    expect(GetIt.I<CardRepository>(), isA<AssetCardRepository>());
  });

  test('Service Locator registers CardHand', () {
    setupServiceLocator();
    expect(GetIt.I<CardHand>(), isA<AssetCardHand>());
  });

  test('Service Locator registers BoardBloc', () {
    setupServiceLocator();
    expect(GetIt.I<BoardBloc>(), isA<BoardBloc>());
  });

  test('Service Locator registers CardDeckBloc with dependencies', () {
    setupServiceLocator();
    expect(GetIt.I<CardDeckBloc>(), isA<CardDeckBloc>());
  });

  test('Service Locator registers CardGridBloc', () {
    setupServiceLocator();
    expect(GetIt.I<GridBoardBloc>(), isA<GridBoardBloc>());
  });

  test('Service Locator registers PlayerHandBloc', () {
    setupServiceLocator();
    expect(GetIt.I<PlayerHandBloc>(), isA<PlayerHandBloc>());
  });
}