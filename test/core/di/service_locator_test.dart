import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:alchemy_tcg/core/di/service_locator.dart';
import 'package:alchemy_tcg/data/repositories/asset_card_repository.dart';
import 'package:alchemy_tcg/domain/repositories/card_repository.dart';
import 'package:alchemy_tcg/presentation/blocs/board/board_bloc.dart';
import 'package:alchemy_tcg/presentation/blocs/card_deck/card_deck_bloc.dart';
import 'package:alchemy_tcg/presentation/blocs/card_grid/card_grid_bloc.dart';
import 'package:alchemy_tcg/presentation/blocs/player_hand/player_hand_bloc.dart';
import 'package:alchemy_tcg/domain/repositories/card_hand.dart';
import 'package:alchemy_tcg/data/repositories/asset_card_hand.dart';

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
    expect(GetIt.I<CardGridBloc>(), isA<CardGridBloc>());
  });

  test('Service Locator registers PlayerHandBloc', () {
    setupServiceLocator();
    expect(GetIt.I<PlayerHandBloc>(), isA<PlayerHandBloc>());
  });
}