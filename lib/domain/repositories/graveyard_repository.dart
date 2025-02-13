abstract class GraveyardRepository {
  Future<List<String>> getCardsGraveyard();
  Future<void> addCard(String cardPath);
  Future<List<String>> showCards();
  Future<void> removeCard(int index);
}