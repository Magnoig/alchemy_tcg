import 'package:alchemy_tcg/domain/repositories/card_hand.dart';

class CardHandScenarios extends CardHand {
  final List<String> _cards = [];

  @override
  Future<List<String>> getCards() async {
    return _cards;
  }

  @override
  Future<void> addCard(String cardPath) async {
    _cards.add(cardPath);
  }

  @override
  Future<void> removeCard(String cardPath) async {
    _cards.remove(cardPath);
  }

  @override
  Future<void> reorderCards(int oldIndex, int newIndex) async {
    newIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    final card = _cards.removeAt(oldIndex);
    _cards.insert(newIndex, card);
  }
}