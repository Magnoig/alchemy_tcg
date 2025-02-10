class DeckState {
  final List<String> cardImages;

  DeckState({required this.cardImages});

  factory DeckState.initial() {
    return DeckState(cardImages: []);
  }

  DeckState copyWith({
    List<String>? cardImages,
  }) {
    return DeckState(
      cardImages: cardImages ?? this.cardImages,
    );
  }
} 