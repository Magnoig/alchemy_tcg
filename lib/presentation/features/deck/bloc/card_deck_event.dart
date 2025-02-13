abstract class DeckEvent {}

class AddCard extends DeckEvent {
  final String cardPath;

  AddCard({required this.cardPath});
}

class RemoveCard extends DeckEvent {
  final int index;

  RemoveCard({required this.index});
}

class InitializeDeck extends DeckEvent {} 

class ShuffleDeck extends DeckEvent {}