abstract class GridBoard {
  Future<void> startDraggingCard(String cardPath);
  Future<void> stopDraggingCard();
  Future<void> hoverOverCell(int row, int col);
  Future<void> leaveCell(int row, int col);
}