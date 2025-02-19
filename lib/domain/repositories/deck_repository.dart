
abstract class DeckRepository {
  Future<Map<String, List<String>>> getCards(String cellId);
  Future<void> addCard(String cellId, String cardPath);
  Future<void> removeCard(String cellId, int index);
  Future<String?> getCardBack();
  Future<void> shuffleDeck(String cellId);
} 