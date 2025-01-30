import '../../domain/repositories/card_hand.dart';
class AssetCardHand implements CardHand {
  final List<String> _cards = [
  ];

  @override
  Future<List<String>> getCards() async {
    return List.from(_cards);
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
    newIndex = oldIndex < newIndex
        ? newIndex - 1
        : newIndex;
    final item = _cards.removeAt(oldIndex);
    _cards.insert(newIndex, item);
  }
} 