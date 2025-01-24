import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/card_deck/card_deck_bloc.dart';
import '../blocs/card_deck/card_deck_state.dart';
import '../blocs/card_deck/card_deck_event.dart';

class CardDeck extends StatelessWidget {
  const CardDeck({super.key});

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
            ...state.cardImages.take(state.cardImages.length - 1).map((imagePath) {
              return Positioned(
                top: 0.0,
                left: 0.0,
                child: Image.asset(
                  'assets/images/card_verso.png',
                  width: 100,
                  height: 150,
                ),
              );
            }),

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
                childWhenDragging: Image.asset(
                  'assets/images/card_verso.png',
                  width: 100,
                  height: 150,
                ),
                child: Image.asset(
                  'assets/images/card_verso.png',
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