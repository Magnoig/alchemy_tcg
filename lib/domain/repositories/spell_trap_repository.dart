abstract class SpellTrapRepository {
  Future<Map<String, List<String>>> getCards();
  Future<void> addCard(String cellId, String cardPath);
  Future<void> removeCard(String cellId, int index);
}