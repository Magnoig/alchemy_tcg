class GraveyardState {
  final List<String> cardImages;

  GraveyardState({required this.cardImages});

  factory GraveyardState.initial() {
    return GraveyardState(cardImages: []);
  }

  GraveyardState copyWith({
    List<String>? cardImages,
  }) {
    return GraveyardState(
      cardImages: cardImages ?? this.cardImages,
    );
  }

  String? getCardBelowTop() {
    final stack = cardImages;
    if (stack.length < 2) return null;
    return stack[stack.length - 2];
  }
} 