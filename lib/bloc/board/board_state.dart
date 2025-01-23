class BoardState {
  // Agora cada posição tem uma lista de cartas (pilha)
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

  // Método auxiliar para obter a carta do topo de uma posição
  String? getTopCard(String position) {
    final stack = boardCards[position];
    if (stack == null || stack.isEmpty) return null;
    return stack.last;
  }

  // Método auxiliar para obter a carta abaixo do topo
  String? getCardBelowTop(String position) {
    final stack = boardCards[position];
    if (stack == null || stack.length < 2) return null;
    return stack[stack.length - 2];
  }
} 