abstract class BoardEvent {}

class PlaceCard extends BoardEvent {
  final int row;
  final int col;
  final String cardPath;

  PlaceCard({
    required this.row,
    required this.col,
    required this.cardPath,
  });
} 