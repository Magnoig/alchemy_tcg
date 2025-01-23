class BoardState {
  final Map<String, List<String>> boardCards;

  BoardState({required this.boardCards});

  factory BoardState.initial() {
    return BoardState(boardCards: {});
  }

  BoardState copyWith({
    Map<String, List<String>>? boardCards,
  }) {
    return BoardState(
      boardCards: boardCards ?? Map.from(boardCards!.map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      )),
    );
  }

  String? getTopCard(String position) {
    final stack = boardCards[position];
    if (stack == null || stack.isEmpty) return null;
    return stack.last;
  }

  String? getCardBelowTop(String position) {
    final stack = boardCards[position];
    if (stack == null || stack.length < 2) return null;
    return stack[stack.length - 2];
  }
} 