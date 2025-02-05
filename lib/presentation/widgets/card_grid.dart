import 'package:flutter/material.dart';
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
    // Posição do deck
    if (GameConstants.isDeckPosition(row, col)) {
      return DeckCell(cellSize: cellSize);
    }

    // Área jogável
    if (GameConstants.isPlayablePosition(row, col)) {
      return BoardCell(
        row: row,
        col: col,
        cellSize: cellSize,
        onCardRemoved: (_) {},
        onShowZoom: _showCardZoom,
      );
    }

    // Células não jogáveis
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(128, 128, 128, 0.2)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cellSize = screenWidth / GameConstants.gridSize;

    return Scaffold(
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
          ),
        ],
      ),
    );
  }
} 