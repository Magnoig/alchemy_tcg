abstract class BoardEvent {}

class AddCard extends BoardEvent {
  final int row;
  final int col;
  final String cardPath;

  AddCard({
    required this.row,
    required this.col,
    required this.cardPath,
  });
}

class RemoveCard extends BoardEvent {
  final int row;
  final int col;
  final String cardPath;

  RemoveCard({
    required this.row,
    required this.col,
    required this.cardPath,
  });
} 