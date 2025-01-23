import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_grid_bloc.dart';
import '../bloc/card_grid_state.dart';
import 'card_deck.dart';

class CardGrid extends StatelessWidget {
  Widget _buildGridCell(int row, int col, double cellSize) {
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
            bottom: -cellSize, // Ajustado para ficar mais acima
            right: -cellSize*0.65, // Ajustado para centralizar horizontalmente
            child: SizedBox(
              width: cellSize * 1.4, // Aumentado para dar mais espaço para as cartas
              height: cellSize * 1.8, // Aumentado proporcionalmente
              child: CardDeck(),
            ),
          ),
        ],
      );
    }
    
    // Células centrais (5x5)
    bool isCentral = row >= 1 && row <= 5 && col >= 1 && col <= 5;
    
    return Card(
      color: isCentral ? Colors.blue : Colors.grey,
      child: Center(
        child: Text(isCentral ? 'Central' : 'Outer'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cellSize = screenWidth / 7;

    return Scaffold(
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
                        return _buildGridCell(row, col, cellSize);
                      },
                    );
                  },
                );
              },
            ),
          ),
          Container(
            height: 100,
            color: Colors.black12,
            child: Center(
              child: Text('Cartas na Mão do Jogador'),
            ),
          ),
        ],
      ),
    );
  }
} 