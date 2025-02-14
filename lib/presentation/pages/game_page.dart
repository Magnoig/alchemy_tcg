import 'package:alchemy_tcg/presentation/features/card_pile/widgets/card_pile_bottom_sheet.dart';
import 'package:alchemy_tcg/presentation/features/hand/bloc/player_hand_event.dart';
import 'package:alchemy_tcg/presentation/features/zoom/implementations/default_card_zoom_handler.dart';
import 'package:alchemy_tcg/presentation/pages/game_page_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/grid/widgets/card_grid.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dependencies = GamePageDependencies.initialize(context);
    final zoomHandler = DefaultCardZoomHandler();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => dependencies.boardBloc),
        BlocProvider(create: (_) => dependencies.deckBloc),
        BlocProvider(create: (_) => dependencies.playerHandBloc),
        BlocProvider(create: (_) => dependencies.graveyardBloc),
      ],
      child: CardGrid(
        onDoubleTap: () => showCardPileBottomSheet(
          context, "Cartas na Mão", dependencies.playerHandBloc.state.cards,
        ), 
        onCardAdded: (cardPath) => dependencies.playerHandBloc.add(AddCardHand(cardPath)), 
        onCardRemoved: (index) => dependencies.playerHandBloc.add(RemoveCardHand(index)), 
        deckBloc: dependencies.deckBloc, 
        graveyardBloc: dependencies.graveyardBloc, 
        boardBloc: dependencies.boardBloc,
        playerHandBloc: dependencies.playerHandBloc, 
        deckRepository: dependencies.deckRepository, 
        onShowZoom: zoomHandler.showCardZoom, 
        onDoubleTapDeck: dependencies.onDoubleTapDeck, 
        onCardAddedDeck: dependencies.onCardAddedDeck, 
        onCardRemovedDeck: dependencies.onCardRemovedDeck, 
        onDoubleTapGraveyard: dependencies.onDoubleTapGraveyard, 
        onCardAddedGraveyard: dependencies.onCardAddedGraveyard, 
        onCardRemovedGraveyard: dependencies.onCardRemovedGraveyard,
      ),
    );
  }
}
