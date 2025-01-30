import 'package:alchemy_tcg/domain/repositories/card_repository.dart';

class MockCardRepository implements CardRepository {
  @override
  Future<List<String>> getCards() async {
    return ['card1.png', 'card2.png', 'card3.png']; // Return mock data
  }

  @override
  Future<String?> getCardBack() async {
    return 'card_back.png'; // Return mock data
  }

  @override
  Future<void> shuffleDeck() async {
    // Mock shuffle logic if needed
  }

  @override
  Future<List<String>> removeTopCard(List<String> cardImages) async {
    return List.from(cardImages)..removeLast();
  }

  @override
  Future<void> addCard(String cardPath) async {
    // Mock add card logic if needed
  }
}