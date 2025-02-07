import 'package:alchemy_tcg/presentation/graveyard/bloc/graveyard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/service_locator.dart';
import '../board/bloc/board_bloc.dart';
import '../deck/bloc/card_deck_bloc.dart';
import '../blocs/grid_board/grid_board_bloc.dart';
import '../hand/bloc/player_hand_bloc.dart';
import '../widgets/card_grid.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<BoardBloc>()),
        BlocProvider(create: (context) => getIt<CardDeckBloc>()),
        BlocProvider(create: (context) => getIt<GridBoardBloc>()),
        BlocProvider(create: (context) => getIt<PlayerHandBloc>()),
        BlocProvider(create: (context) => getIt<GraveyardBloc>()),
      ],
      child: const CardGrid(),
    );
  }
} 