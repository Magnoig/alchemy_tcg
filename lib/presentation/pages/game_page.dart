// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:alchemy_tcg/presentation/features/card_pile/widgets/card_pile_bottom_sheet.dart';
import 'package:alchemy_tcg/presentation/features/hand/bloc/player_hand_event.dart';
import 'package:alchemy_tcg/presentation/pages/game_page_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/grid/widgets/card_grid.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dependencies = GamePageDependencies.initialize(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => dependencies.boardBloc),
        BlocProvider(create: (_) => dependencies.deckBloc),
        BlocProvider(create: (_) => dependencies.playerHandBloc),
        BlocProvider(create: (_) => dependencies.graveyardBloc),
      ],
      child: CardGrid(
        zoomHandler: dependencies.zoomHandler,
        layoutManager: dependencies.layoutManager,
        scrollManager: dependencies.scrollManager, 
        playerHandBloc: dependencies.playerHandBloc, 
        onDoubleTap: () => showCardPileBottomSheet(context, "Cartas na Mâo", dependencies.playerHandBloc.state.cards), 
        onCardAdded: (cardPath) => dependencies.playerHandBloc.add(AddCard(cardPath),), 
        onCardRemoved: (index) => dependencies.playerHandBloc.add(RemoveCard(index)),
      ),
    );
  }
}