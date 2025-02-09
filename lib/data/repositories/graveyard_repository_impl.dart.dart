import 'package:alchemy_tcg/domain/repositories/graveyard_repository.dart';

class GraveyardRepositoryImpl implements GraveyardRepository{
  final List<String> graveyard = [];
  @override
  Future<void> addCard(String cardPath) async {
    graveyard.add(cardPath);
  }

  @override
  Future<List<String>> getCardsGraveyard() async {
    return List.from(graveyard);
  }

  @override
  Future<List<String>> showCards() {
    // TODO: implement showCards
    throw UnimplementedError();
  }
  
  @override
  Future<void> removeTopCard(List<String> cardImages) async {
    if (cardImages.isNotEmpty) {
      graveyard.removeLast();
    }
  }
}