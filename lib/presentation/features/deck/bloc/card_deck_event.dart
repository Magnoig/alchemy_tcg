abstract class DeckEvent {}

class AddCardDeck extends DeckEvent {
  final String cardPath;

  AddCardDeck({required this.cardPath});
}

class RemoveCardDeck extends DeckEvent {
  final int index;

  RemoveCardDeck({required this.index});
}

class InitializeDeck extends DeckEvent {} 

class ShuffleDeck extends DeckEvent {}