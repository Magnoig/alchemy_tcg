import 'package:alchemy_tcg/domain/services/grid_board.dart';
import 'package:alchemy_tcg/presentation/blocs/grid_board/grid_board_state.dart';

class GridBoardService implements GridBoard {
  final List<List<CellState>> cellStates;
  final Set<String> validPositions;
  late final newCellStates = List<List<CellState>>.from(
      cellStates.map((row) => List<CellState>.from(row)),
    );

  GridBoardService({
    required this.cellStates,
    required this.validPositions,
  });

  @override
  Future<void> startDraggingCard(String cardPath) async {

    for (int row = 0; row < 5; row++) {
      for (int col = 0; col < 5; col++) {
        if (cellStates[row][col] == CellState.empty) {
          validPositions.add('$row,$col');
          newCellStates[row][col] = CellState.valid;
        }
      }
    }
  }

  @override
  Future<void> stopDraggingCard() async {
    for (int row = 0; row < 5; row++) {
      for (int col = 0; col < 5; col++) {
        if (newCellStates[row][col] != CellState.empty) {
          newCellStates[row][col] = CellState.empty;
        }
      }
    }
  }

  @override
  Future<void> hoverOverCell(int row, int col) async {
    if (row < 0 || row >= 5 || col < 0 || col >= 5) return;

    if (validPositions.contains('$row,$col')) {
      newCellStates[row][col] = CellState.highlighted;
    }
  }

  @override
  Future<void> leaveCell(int row, int col) async {
    if (row < 0 || row >= 5 || col < 0 || col >= 5) return;

    if (validPositions.contains('$row,$col')) {
      newCellStates[row][col] = CellState.valid;
    } else {
      newCellStates[row][col] = CellState.empty;
    }
  }
}