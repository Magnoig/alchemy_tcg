import 'package:flutter_test/flutter_test.dart';
import 'card_hand_scenarios.dart';
void main() {
  late CardHandScenarios cardHandScenarios;

  setUp(() {
    cardHandScenarios = CardHandScenarios();
  });

  group('CardHandScenarios', () {
    test('getCards returns an empty list initially', () async {
      final cards = await cardHandScenarios.getCards();
      expect(cards, isEmpty);
    });

    test('addCard adds a card to the hand', () async {
      final cardPath = 'assets/images/card.png';
      await cardHandScenarios.addCard(cardPath);
      final cards = await cardHandScenarios.getCards();
      expect(cards, contains(cardPath));
    });

    test('removeCard removes a card from the hand', () async {
      final cardPath = 'assets/images/card.png';
      await cardHandScenarios.addCard(cardPath);
      await cardHandScenarios.removeCard(cardPath);
      final cards = await cardHandScenarios.getCards();
      expect(cards, isNot(contains(cardPath)));
    });

    test('reorderCards reorders the cards', () async {
      final cards = ['assets/images/card1.png', 'assets/images/card2.png'];
      await cardHandScenarios.addCard(cards[0]);
      await cardHandScenarios.addCard(cards[1]);
      await cardHandScenarios.reorderCards(0, 1);
      final newCards = await cardHandScenarios.getCards();
      expect(newCards, equals(cards));
    });
  });
  

}
