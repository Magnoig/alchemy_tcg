abstract class PlayerHandEvent {}

class AddCard extends PlayerHandEvent {
  final String cardPath;
  AddCard(this.cardPath);
}

class RemoveCard extends PlayerHandEvent {
  final int index;
  RemoveCard(this.index);
}
 