abstract class CardDeckEvent {}

class RemoveTopCard extends CardDeckEvent {}

class InitializeDeck extends CardDeckEvent {} 

class ShuffleDeck extends CardDeckEvent {}