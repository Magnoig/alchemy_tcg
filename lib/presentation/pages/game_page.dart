import 'package:alchemy_tcg/presentation/pages/game_page_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/grid/widgets/card_grid.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dependencies = GamePageDependencies.initialize();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => dependencies.boardBloc),
        BlocProvider(create: (_) => dependencies.deckBloc),
        BlocProvider(create: (_) => dependencies.gridBoardBloc),
        BlocProvider(create: (_) => dependencies.playerHandBloc),
        BlocProvider(create: (_) => dependencies.graveyardBloc),
      ],
      child: CardGrid(
        zoomHandler: dependencies.zoomHandler,
        layoutManager: dependencies.layoutManager,
        scrollManager: dependencies.scrollManager, 
        playerHandBloc: dependencies.playerHandBloc,
      ),
    );
  }
}