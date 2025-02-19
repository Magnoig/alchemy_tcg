class DeckState {
  final Map<String, List<String>> cellDecks;

  DeckState({required this.cellDecks});

  factory DeckState.initial() {
    return DeckState(cellDecks: {});
  }

  DeckState copyWith({
    Map<String, List<String>>? cellDecks,
  }) {
    return DeckState(
      cellDecks: cellDecks ?? this.cellDecks,
    );
  }
}
