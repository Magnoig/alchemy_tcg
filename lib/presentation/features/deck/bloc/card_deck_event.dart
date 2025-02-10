abstract class DeckEvent {}

class RemoveTopCard extends DeckEvent {}

class InitializeDeck extends DeckEvent {} 

class ShuffleDeck extends DeckEvent {}