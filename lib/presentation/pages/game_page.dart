import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/service_locator.dart';
import '../blocs/board/board_bloc.dart';
import '../blocs/card_deck/card_deck_bloc.dart';
import '../blocs/grid_board/grid_board_bloc.dart';
import '../blocs/player_hand/player_hand_bloc.dart';
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
      ],
      child: const CardGrid(),
    );
  }
} 