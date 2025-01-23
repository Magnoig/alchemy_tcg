import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_grid_bloc.dart';
import '../bloc/card_grid_state.dart';

class CardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo de Cartas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CardGridBloc, CardGridState>(
              builder: (context, state) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7, // Total de colunas
                  ),
                  itemCount: 49, // Total de células (7x7)
                  itemBuilder: (context, index) {
                    final row = index ~/ 7;
                    final col = index % 7;

                    // Verifica se está na parte central (5x5)
                    bool isCentral = row >= 1 && row <= 5 && col >= 1 && col <= 5;

                    return Card(
                      color: isCentral ? Colors.blue : Colors.grey, // Diferencia a cor
                      child: Center(
                        child: Text(isCentral ? 'Central' : 'Outer'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            height: 100, // Altura da área das cartas na mão
            color: Colors.black12, // Cor de fundo para diferenciar
            child: Center(
              child: Text('Cartas na Mão do Jogador'),
            ),
          ),
        ],
      ),
    );
  }
} 