import 'package:flutter/material.dart';
import 'package:alchemy_tcg/core/di/service_locator.dart';
import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';

class CardStack extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;

  const CardStack({
    super.key,
    required this.cardWidth,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 2; i >= 0; i--)
            Positioned(
              top: -i * 2.0,
              right: -i * 2.0,
              child: Card(
                child: FutureBuilder<String?>(
                  future: getIt<DeckRepository>().getCardBack(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Icon(Icons.error));
                    } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return Container();
                    } else {
                      return Image.asset(
                        snapshot.data!,
                        width: cardWidth,
                        height: cardHeight,
                        fit: BoxFit.cover,
                      );
                    }
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}