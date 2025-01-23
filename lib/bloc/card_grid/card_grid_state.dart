enum CellState {
  empty,
  valid,
  invalid,
  highlighted
}

class CardGridState {
  final List<List<CellState>> cellStates;
  final Set<String> validPositions; // Posições válidas para a carta atual sendo arrastada

  CardGridState({
    required this.cellStates,
    this.validPositions = const {},
  });

  factory CardGridState.initial() {
    // Cria uma matriz 5x5 com todas as células vazias
    final initialCellStates = List.generate(
      5,
      (_) => List.filled(5, CellState.empty),
    );

    return CardGridState(
      cellStates: initialCellStates,
      validPositions: {},
    );
  }

  CardGridState copyWith({
    List<List<CellState>>? cellStates,
    Set<String>? validPositions,
  }) {
    return CardGridState(
      cellStates: cellStates ?? List.from(this.cellStates.map((row) => List.from(row))),
      validPositions: validPositions ?? Set.from(this.validPositions),
    );
  }
} 