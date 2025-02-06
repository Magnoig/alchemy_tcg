import 'package:flutter/material.dart';

void showCardPileBottomSheet(BuildContext context, String title, List<String> cardImages) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return CardPileBottomSheet(title: title, cardImages: cardImages);
    },
  );
}

class CardPileBottomSheet extends StatelessWidget {
  final String title;
  final List<String> cardImages;

  const CardPileBottomSheet({
    super.key,
    required this.title,
    required this.cardImages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: cardImages.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Image.asset(cardImages[index], fit: BoxFit.cover),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}