abstract class HandRepository {
  Future<List<String>> getCards();
  Future<void> addCard(String cardPath);
  Future<void> removeCard(String cardPath);
  Future<void> reorderCards(int oldIndex, int newIndex);
}