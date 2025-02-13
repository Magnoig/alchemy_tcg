
abstract class DeckRepository {
  Future<List<String>> getCards();
  Future<void> addCard(String cardPath);
  Future<void> removeCard(int index);
  Future<String?> getCardBack();
  Future<void> shuffleDeck();
} 