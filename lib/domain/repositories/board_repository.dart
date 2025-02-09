abstract class BoardRepository {
  Future<Map<String, List<String>>> getBoardCards();
  Future<void> placeCard(String cardPath, int row, int col);
  Future<void> removeCard(int row, int col);
}