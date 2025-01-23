class CardDeckState {
  final List<String> cardImages;

  CardDeckState({required this.cardImages});

  factory CardDeckState.initial() {
    return CardDeckState(cardImages: []);
  }

  CardDeckState copyWith({
    List<String>? cardImages,
  }) {
    return CardDeckState(
      cardImages: cardImages ?? this.cardImages,
    );
  }
} 