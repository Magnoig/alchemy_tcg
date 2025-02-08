import 'package:alchemy_tcg/core/di/service_locator.dart';
import 'package:alchemy_tcg/presentation/graveyard/widget/gaveyard_cell.dart';
import 'package:alchemy_tcg/presentation/hand/bloc/player_hand_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/game_constants.dart';
import '../board/widget/board_cell.dart';
import 'card_zoom.dart';
import '../deck/widget/deck_cell.dart';
import '../hand/widget/player_hand.dart';

class CardGrid extends StatefulWidget {
  const CardGrid({super.key});

  @override
  CardGridState createState() => CardGridState();
}

class CardGridState extends State<CardGrid> {
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

  Widget _buildCell(int row, int col, double cellSize) {
    if (GameConstants.isDeckPosition(row, col)) {
      return DeckCell(cellSize: cellSize);
    }

    if (GameConstants.isGraveyardPosition(row, col)) {
      return GraveyardCell(cellSize: cellSize);
    }

    if (GameConstants.isPlayablePosition(row, col)) {
      return BoardCell(
        row: row,
        col: col,
        cellSize: cellSize,
        onCardRemoved: (_) {},
        onShowZoom: _showCardZoom,
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(128, 128, 128, 0.2)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PlayerHandBloc playerHandBloc = getIt<PlayerHandBloc>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cellSize = screenWidth / GameConstants.gridSize;

    return BlocProvider<PlayerHandBloc>(
      create: (context) => playerHandBloc,
      child: Builder(
        builder: (context) => Scaffold(
      appBar: AppBar(
        title: const Text('TCG'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: GameConstants.gridSize,
                childAspectRatio: GameConstants.cardAspectRatio,
              ),
              itemCount: GameConstants.gridSize * GameConstants.gridSize,
              itemBuilder: (context, index) {
                final row = index ~/ GameConstants.gridSize;
                final col = index % GameConstants.gridSize;
                return _buildCell(row, col, cellSize);
              },
            ),
          ),
          PlayerHand(
                onShowZoom: _showCardZoom,
                playerHandBloc: playerHandBloc,
          ),
        ],
      ),
        ),
      ),
    );
  }
} 