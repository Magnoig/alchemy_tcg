abstract class BoardRepository {
  Future<Map<String, List<String>>> getCards();
  Future<void> addCard(String cardPath, int row, int col);
  Future<void> removeCard(String cardPath, int row, int col);
}