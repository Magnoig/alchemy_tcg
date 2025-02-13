import 'package:alchemy_tcg/core/constants/game_constants.dart';
import 'package:alchemy_tcg/core/theme/game_theme.dart';
import 'package:alchemy_tcg/presentation/features/hand/widget/draggable_card.dart';
import 'package:flutter/material.dart';

class PlayerHandView extends StatelessWidget {
  final List<String> cardImages;
  final Function(BuildContext, String) onShowZoom;
  final Function(int) onRemoveCard;
  final Function(String) onAddCard;

  const PlayerHandView({
    super.key,
    required this.cardImages,
    required this.onShowZoom,
    required this.onRemoveCard,
    required this.onAddCard,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double cardWidth = 100.0;
    const double minSpacing = 10.0;

    double spacing = minSpacing;

    if (cardImages.length > 1) {
      double availableWidth = screenWidth - cardWidth;
      spacing = (availableWidth / (cardImages.length - 1)).clamp(10.0, cardWidth * 0.6);
    }

    return DragTarget<String>(
      onWillAcceptWithDetails: (details) => details.data.isNotEmpty,
      onAcceptWithDetails: (details) => onAddCard(details.data),
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: GameConstants.handHeight,
          color: GameTheme.handBackgroundColor,
          child: cardImages.isEmpty
              ? const Center(child: Text('Empty Hand'))
              : GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    Scrollable.of(context).position.moveTo(
                      Scrollable.of(context).position.pixels - details.delta.dx,
                      clamp: true,
                    );
                  },
                  child: SizedBox(
                    width: screenWidth,
                    child: Stack(
                      children: List.generate(cardImages.length, (index) {
                        return Positioned(
                          left: index * spacing,
                          child: DraggableCard(
                            cardPath: cardImages[index],
                            onDragEnd: (wasAccepted) {
                              if (wasAccepted) onRemoveCard(index);
                            },
                            onTap: () => onShowZoom(context, cardImages[index]),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
        );
      },
    );
  }
}