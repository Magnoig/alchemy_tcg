
abstract class CardRepository {
  Future<List<String>> getCards();
  Future<String?> getCardBack();
  Future<void> shuffleDeck();
} 