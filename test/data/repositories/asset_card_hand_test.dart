import 'package:flutter_test/flutter_test.dart';
import 'package:alchemy_tcg/data/repositories/hand_repository_impl.dart';

void main() {
  late AssetCardHand assetCardHand;

  setUp(() {
    assetCardHand = AssetCardHand();
  });

  group('AssetCardHand', () {
    test('getCards returns a list of card paths', () async {
      final cards = await assetCardHand.getCards();
      expect(cards, isA<List<String>>());
      expect(cards.length, equals(0));
    });

    test('addCard adds a card to the hand', () async {
      final cardPath = 'assets/images/card.png';
      await assetCardHand.addCard(cardPath);
      final cards = await assetCardHand.getCards();
      expect(cards, contains(cardPath));
    });

    test('removeCard removes a card from the hand', () async {
      final cardPath = 'assets/images/card.png';
      await assetCardHand.addCard(cardPath);
      await assetCardHand.removeCard(cardPath);
      final cards = await assetCardHand.getCards();
      expect(cards, isNot(contains(cardPath)));
    });

    test('reorderCards reorders the cards', () async {
      final cards = ['assets/images/card1.png', 'assets/images/card2.png'];
      await assetCardHand.addCard(cards[0]);
      await assetCardHand.addCard(cards[1]);
      await assetCardHand.reorderCards(0, 1);
      final newCards = await assetCardHand.getCards();
      expect(newCards, equals(cards));
    });
  });
}
