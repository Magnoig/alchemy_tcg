abstract class HandRepository {
  Future<List<String>> getCards();
  Future<void> addCard(String cardPath);
  Future<void> removeCard(int index);
}