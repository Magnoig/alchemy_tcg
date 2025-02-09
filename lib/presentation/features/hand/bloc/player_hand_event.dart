abstract class PlayerHandEvent {}

class AddCard extends PlayerHandEvent {
  final String cardPath;
  AddCard(this.cardPath);
}

class RemoveCard extends PlayerHandEvent {
  final String cardPath;
  RemoveCard(this.cardPath);
}

class ReorderCards extends PlayerHandEvent {
  final int oldIndex;
  final int newIndex;
  ReorderCards(this.oldIndex, this.newIndex);
} 