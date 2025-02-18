class SpellTrapState {
  final List<String> cardImages;

  SpellTrapState({required this.cardImages});

  factory SpellTrapState.initial() {
    return SpellTrapState(cardImages: []);
  }

  SpellTrapState copyWith({
    List<String>? cardImages
  }) {
    return SpellTrapState(
      cardImages: cardImages ?? this.cardImages,
    );
  }

  // String? getTopCard(String position) {
  //   final stack = boardCards[position];
  //   if (stack == null || stack.isEmpty) return null;
  //   return stack.last;
  // }

  // String? getCardBelowTop(String position) {
  //   final stack = boardCards[position];
  //   if (stack == null || stack.length < 2) return null;
  //   return stack[stack.length - 2];
  // }
} 