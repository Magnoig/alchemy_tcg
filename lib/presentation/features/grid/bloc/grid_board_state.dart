import 'package:alchemy_tcg/domain/entities/cell_state.dart';

class GridBoardState {
  final List<List<CellState>> cellStates;
  final Set<String> validPositions;

  GridBoardState({
    required this.cellStates,
    this.validPositions = const {},
  });

  factory GridBoardState.initial() {
    final initialCellStates = List.generate(
      5,
      (_) => List.filled(5, CellState.empty),
    );

    return GridBoardState(
      cellStates: initialCellStates,
      validPositions: {},
    );
  }

  GridBoardState copyWith({
    List<List<CellState>>? cellStates,
    Set<String>? validPositions,
  }) {
    return GridBoardState(
      cellStates: cellStates ?? List.from(this.cellStates.map((row) => List.from(row))),
      validPositions: validPositions ?? Set.from(this.validPositions),
    );
  }
} 