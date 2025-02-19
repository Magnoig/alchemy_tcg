import 'package:alchemy_tcg/domain/repositories/graveyard_repository.dart';

class GraveyardRepositoryImpl implements GraveyardRepository{
  final Map<String, List<String>> graveyard = {}; 

  @override
  Future<Map<String, List<String>>> getCards() async {
    return Map.from(graveyard);
  }

  @override
  Future<void> addCard(String cellId, String cardPath) async {
    if (!graveyard.containsKey(cellId)) {
      graveyard[cellId] = []; 
    }
    graveyard[cellId]!.add(cardPath);
  }

  @override
  Future<void> removeCard(String cellId, int index) async {
    if (graveyard.containsKey(cellId)) {
      List<String> cards = graveyard[cellId]!;

      if (index >= 0 && index < cards.length) {
        cards.removeAt(index);
      }

      if (cards.isEmpty) {
        graveyard.remove(cellId);
      }
    }
  }
}