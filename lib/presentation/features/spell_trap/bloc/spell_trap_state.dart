class SpellTrapState {
  final Map<String, List<String>> spellTrapCards;

  SpellTrapState({required this.spellTrapCards});

  factory SpellTrapState.initial() {
    return SpellTrapState(spellTrapCards: {});
  }

  SpellTrapState copyWith({
    Map<String, List<String>>? spellTrapCards,
  }) {
    return SpellTrapState(
      spellTrapCards: spellTrapCards ?? this.spellTrapCards,
    );
  }

  String? getTopCard(String position) {
    final stack = spellTrapCards[position];
    return (stack?.isNotEmpty == true) ? stack!.last : null;
  }

  String? getCardBelowTop(String position) {
    final stack = spellTrapCards[position];
    return (stack != null && stack.length > 1) ? stack[stack.length - 2] : null;
  }
} 