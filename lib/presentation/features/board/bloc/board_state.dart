class BoardState {
  final List<String> cardImages;

  BoardState({required this.cardImages});

  factory BoardState.initial() {
    return BoardState(cardImages: []);
  }

  BoardState copyWith({
    List<String>? cardImages
  }) {
    return BoardState(
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