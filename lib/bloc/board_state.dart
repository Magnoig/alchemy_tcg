class BoardState {
  final Map<String, String> boardCards; // key: "row,col", value: cardPath

  BoardState({required this.boardCards});

  factory BoardState.initial() {
    return BoardState(boardCards: {});
  }

  BoardState copyWith({
    Map<String, String>? boardCards,
  }) {
    return BoardState(
      boardCards: boardCards ?? this.boardCards,
    );
  }
} 