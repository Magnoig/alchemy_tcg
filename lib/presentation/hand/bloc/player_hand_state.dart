import 'package:flutter/foundation.dart';

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerHandState &&
          runtimeType == other.runtimeType &&
          listEquals(cards, other.cards);

  @override
  int get hashCode => cards.hashCode;
} 