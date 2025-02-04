abstract class GridBoardEvent {}

class StartDraggingCard extends GridBoardEvent {
  final String cardPath;
  StartDraggingCard(this.cardPath);
}

class StopDraggingCard extends GridBoardEvent {}

class HoverOverCell extends GridBoardEvent {
  final int row;
  final int col;
  HoverOverCell(this.row, this.col);
}

class LeaveCell extends GridBoardEvent {
  final int row;
  final int col;
  LeaveCell(this.row, this.col);
} 