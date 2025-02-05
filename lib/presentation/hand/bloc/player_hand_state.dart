class PlayerHandState {
  final List<String> cards;

  PlayerHandState({required this.cards});

  factory PlayerHandState.initial() {
    return PlayerHandState(cards: []);
  }

  PlayerHandState copyWith({
    List<String>? cards,
  }) {
    return PlayerHandState(
      cards: cards ?? List.from(this.cards),
    );
  }
} 