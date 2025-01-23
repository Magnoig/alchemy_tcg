import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_grid_bloc.dart';
import '../bloc/card_grid_state.dart';
import '../bloc/card_deck_bloc.dart';
import '../bloc/board_bloc.dart';
import '../bloc/board_state.dart';
import '../bloc/board_event.dart';
import 'card_deck.dart';

class CardGrid extends StatefulWidget {
  @override
  _CardGridState createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {
  List<String> playerHand = [];

  Widget _buildGridCell(int row, int col, double cellSize, BuildContext context) {
    // Célula do Deck
    if (row == 6 && col == 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            color: Colors.grey,
            child: Center(
              child: Text('Deck'),
            ),
          ),
          Positioned(
            bottom: -cellSize,
            right: -cellSize*0.65,
            child: SizedBox(
              width: cellSize * 1.4,
              height: cellSize * 1.8,
              child: CardDeck(),
            ),
          ),
        ],
      );
    }
    
    // Células centrais (5x5) e outras células do tabuleiro
    bool isCentral = row >= 1 && row <= 5 && col >= 1 && col <= 5;
    
    return BlocBuilder<BoardBloc, BoardState>(
      builder: (context, state) {
        final cardKey = '$row,$col';
        final cardInCell = state.boardCards[cardKey];

        return DragTarget<String>(
          builder: (context, candidateData, rejectedData) {
            return Stack(
              children: [
                Card(
                  color: isCentral ? Colors.blue : Colors.grey,
                  child: Center(
                    child: Text(isCentral ? 'Central' : 'Outer'),
                  ),
                ),
                if (cardInCell != null)
                  Positioned.fill(
                    child: Image.asset(
                      cardInCell,
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
            );
          },
          onWillAccept: (data) => true,
          onAccept: (cardPath) {
            context.read<BoardBloc>().add(PlaceCard(
              row: row,
              col: col,
              cardPath: cardPath,
            ));
            setState(() {
              playerHand.remove(cardPath);
            });
          },
        );
      },
    );
  }

  Widget _buildPlayerHand() {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 100,
          color: Colors.black12,
          child: playerHand.isEmpty
              ? const Center(
                  child: Text('Arraste cartas do deck para cá'),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: playerHand.length,
                  itemBuilder: (context, index) {
                    final cardPath = playerHand[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Draggable<String>(
                        data: cardPath,
                        feedback: Image.asset(
                          cardPath,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: Image.asset(
                            cardPath,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Image.asset(
                          cardPath,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
        );
      },
      onAccept: (String cardPath) {
        setState(() {
          playerHand.add(cardPath);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cellSize = screenWidth / 7;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BoardBloc()),
        BlocProvider(create: (context) => CardDeckBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Jogo de Cartas'),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CardGridBloc, CardGridState>(
                builder: (context, state) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1,
                        ),
                        itemCount: 49,
                        itemBuilder: (context, index) {
                          final row = index ~/ 7;
                          final col = index % 7;
                          return _buildGridCell(row, col, cellSize, context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            _buildPlayerHand(),
          ],
        ),
      ),
    );
  }
} 