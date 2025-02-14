abstract class PlayerHandEvent {}

class AddCardHand extends PlayerHandEvent {
  final String cardPath;
  AddCardHand(this.cardPath);
}

class RemoveCardHand extends PlayerHandEvent {
  final int index;
  RemoveCardHand(this.index);
}
 