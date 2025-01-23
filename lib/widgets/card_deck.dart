import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_deck_bloc.dart';
import '../bloc/card_deck_state.dart';
import '../bloc/card_deck_event.dart';

class CardDeck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardDeckBloc, CardDeckState>(
      builder: (context, state) {
        if (state.cardImages.isEmpty) {
          return Container();
        }

        String topCard = state.cardImages.last;

        return Stack(
          children: [
            // Cartas do fundo (não arrastáveis)
            ...state.cardImages.take(state.cardImages.length - 1).map((imagePath) {
              return Positioned(
                top: 0.0,
                left: 0.0,
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 150,
                ),
              );
            }).toList(),

            // Carta do topo (arrastável)
            Positioned(
              top: 0.0,
              left: 0.0,
              child: Draggable<String>(
                data: topCard,
                onDragCompleted: () {
                  context.read<CardDeckBloc>().add(RemoveTopCard());
                },
                feedback: Image.asset(
                  topCard,
                  width: 100,
                  height: 150,
                ),
                childWhenDragging: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    topCard,
                    width: 100,
                    height: 150,
                  ),
                ),
                child: Image.asset(
                  topCard,
                  width: 100,
                  height: 150,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
} 