import 'package:alchemy_tcg/domain/repositories/card_repository.dart';

class CardRepositoryScenarios extends CardRepository {
  final List<String> _cards = [];

  @override
  Future<List<String>> getCards() async {
    return _cards;
  }

  Future<void> addCard(String cardPath) async {
    _cards.add(cardPath);
  }

  Future<void> removeCard(String cardPath) async {
    _cards.remove(cardPath);
  }

  @override
  Future<void> shuffleDeck() async {
    _cards.shuffle();
  }

  @override
  Future<String> getCardBack() async {
    return 'assets/images/card_verso.png';
  }

}