import 'package:alchemy_tcg/presentation/features/grid/bloc/grid_board_state.dart';

abstract class GridBoardService {
  Future<void> startDraggingCard(String cardPath);
  Future<void> stopDraggingCard();
  Future<void> hoverOverCell(int row, int col);
  Future<void> leaveCell(int row, int col);
  List<List<CellState>> get newCellStates;
  Set<String> get validPositions;
}