abstract class DeckEvent {}

class AddCardDeck extends DeckEvent {
  final String cellId;
  final String cardPath;

  AddCardDeck({required this.cellId, required this.cardPath});
}

class RemoveCardDeck extends DeckEvent {
  final String cellId;
  final int index;

  RemoveCardDeck({required this.cellId, required this.index});
}

class InitializeDeck extends DeckEvent {
  final String cellId;

  InitializeDeck({required this.cellId});
} 

class ShuffleDeck extends DeckEvent {
  late final String cellId;
}