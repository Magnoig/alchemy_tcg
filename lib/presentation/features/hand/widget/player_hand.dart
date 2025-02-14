import 'package:alchemy_tcg/presentation/features/hand/widget/player_hand_view.dart';
import 'package:flutter/material.dart';

class PlayerHand extends StatelessWidget {
  final Function(BuildContext, String) onShowZoom;
  final VoidCallback onDoubleTap;
  final void Function(String) onCardAdded;
  final void Function(int index) onCardRemoved;
  final List<String> cardImages;

  const PlayerHand({
    super.key,
    required this.onShowZoom, 
    required this.onDoubleTap, 
    required this.onCardAdded, 
    required this.onCardRemoved, 
    required this.cardImages,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
      onDoubleTap: onDoubleTap,
      child: PlayerHandView(
        cardImages: cardImages,
        onShowZoom: onShowZoom,
        onRemoveCard: onCardRemoved,
        onAddCard: onCardAdded,
      ),
    );
  }
}
