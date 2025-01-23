abstract class CardGridEvent {}

class InitializeGrid extends CardGridEvent {}

class StartDraggingCard extends CardGridEvent {
  final String cardPath;
  StartDraggingCard(this.cardPath);
}

class StopDraggingCard extends CardGridEvent {}

class HoverOverCell extends CardGridEvent {
  final int row;
  final int col;
  HoverOverCell(this.row, this.col);
}

class LeaveCell extends CardGridEvent {
  final int row;
  final int col;
  LeaveCell(this.row, this.col);
} 