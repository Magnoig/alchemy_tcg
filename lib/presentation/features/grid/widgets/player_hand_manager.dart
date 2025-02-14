import 'package:alchemy_tcg/presentation/features/hand/bloc/player_hand_bloc.dart';
import 'package:alchemy_tcg/presentation/features/hand/bloc/player_hand_state.dart';
import 'package:alchemy_tcg/presentation/features/hand/widget/player_hand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerHandManager extends StatelessWidget {
  final Function(BuildContext, String) onShowZoom;
  final void Function(String) onCardAdded;
  final void Function(int) onCardRemoved;
  final VoidCallback onDoubleTap;

  const PlayerHandManager({
    required this.onShowZoom,
    required this.onCardAdded,
    required this.onCardRemoved,
    required this.onDoubleTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerHandBloc, PlayerHandState>(
      builder: (context, state) {
        return PlayerHand(
          onShowZoom: onShowZoom,
          cardImages: state.cards,
          onDoubleTap: onDoubleTap,
          onCardAdded: onCardAdded,
          onCardRemoved: onCardRemoved,
        );
      },
    );
  }
}
