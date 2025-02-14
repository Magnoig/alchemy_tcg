abstract class BoardEvent {}

class AddCardBoard extends BoardEvent {
  final String cardPath;

  AddCardBoard({
    required this.cardPath,
  });
}

class RemoveCardBoard extends BoardEvent {
  final int index;

  RemoveCardBoard({
    required this.index,
  });
} 