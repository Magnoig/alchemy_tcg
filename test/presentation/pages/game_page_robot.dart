import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:alchemy_tcg/presentation/features/grid/widgets/card_grid.dart';
import 'package:alchemy_tcg/presentation/pages/game_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alchemy_tcg/presentation/features/board/bloc/board_bloc.dart';
import 'package:alchemy_tcg/presentation/features/deck/bloc/card_deck_bloc.dart';
import 'game_page_scenarios.dart';

class GamePageRobot {
  final WidgetTester tester;

  GamePageRobot(this.tester);

  Future<void> pumpGamePage() async {
    final boardBloc = BoardBloc(); // Adjust if BoardBloc requires parameters
    final cardDeckBloc = CardDeckBloc(MockCardRepository());
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<BoardBloc>(create: (context) => boardBloc),
          BlocProvider<CardDeckBloc>(create: (context) => cardDeckBloc),
        ],
        child: MaterialApp(home: GamePage()), // Pass the GamePage as a widget
      ),
    );
    await tester.pumpAndSettle(); // Aguarda animações e transições
  }

  Future<void> tapCardGrid() async {
    // Exemplo de interação: clicar no CardGrid
    await tester.tap(find.byType(CardGrid));
    await tester.pumpAndSettle(); // Aguarda animações
  }

  // Adicione mais métodos para interações específicas
}