import 'package:alchemy_tcg/domain/repositories/deck_repository.dart';
import 'package:flutter/material.dart';

class DeckCardBack extends StatelessWidget {
  final DeckRepository deckRepository;
  
  const DeckCardBack({super.key, required this.deckRepository});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FutureBuilder<String?>(
        future: deckRepository.getCardBack(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
            return Container();
          } else {
            return Image.asset(snapshot.data!, fit: BoxFit.contain);
          }
        },
      ),
    );
  }
}