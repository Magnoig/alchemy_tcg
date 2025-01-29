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
}