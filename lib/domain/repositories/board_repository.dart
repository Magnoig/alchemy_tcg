abstract class BoardRepository {
  Future<List<String>> getCards();
  Future<void> addCard(String cardPath);
  Future<void> removeCard(int index);
}