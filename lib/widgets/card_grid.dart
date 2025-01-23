import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_grid/card_grid_bloc.dart';
import '../bloc/card_deck/card_deck_bloc.dart';
import '../bloc/board/board_bloc.dart';
import '../bloc/player_hand/player_hand_bloc.dart';
import '../bloc/player_hand/player_hand_event.dart';
import '../constants/game_constants.dart';
import 'card_zoom.dart';
import 'board_cell.dart';
import 'player_hand.dart';
import 'deck_cell.dart';

class CardGrid extends StatefulWidget {
  @override
  _CardGridState createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {
  final ScrollController _scrollController = ScrollController();

  void _showCardZoom(BuildContext context, String cardPath) {
    showDialog(
      context: context,
      builder: (context) => CardZoom(cardPath: cardPath),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: GameConstants.scrollDuration,
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cellSize = screenWidth / GameConstants.gridSize;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BoardBloc()),
        BlocProvider(create: (context) => CardDeckBloc()),
        BlocProvider(create: (context) => CardGridBloc()),
        BlocProvider(create: (context) => PlayerHandBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Jogo de Cartas'),
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: GameConstants.gridSize,
                  childAspectRatio: 1,
                ),
                itemCount: GameConstants.gridSize * GameConstants.gridSize,
                itemBuilder: (context, index) {
                  final row = index ~/ GameConstants.gridSize;
                  final col = index % GameConstants.gridSize;
                  
                  if (row == GameConstants.deckRow && col == GameConstants.deckCol) {
                    return DeckCell(cellSize: cellSize);
                  }

                  return BoardCell(
                    row: row,
                    col: col,
                    cellSize: cellSize,
                    onCardRemoved: (cardPath) {
                      context.read<PlayerHandBloc>().add(AddCard(cardPath));
                    },
                    onShowZoom: _showCardZoom,
                  );
                },
              ),
            ),
            PlayerHand(
              onShowZoom: _showCardZoom,
            ),
          ],
        ),
      ),
    );
  }
} 