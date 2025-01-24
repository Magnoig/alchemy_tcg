import 'package:flutter_test/flutter_test.dart';
import 'package:alchemy_tcg/data/repositories/asset_card_repository.dart';
void main() {
  late AssetCardRepository assetCardRepository;

  setUp(() {
    assetCardRepository = AssetCardRepository();
  });

  group('AssetCardRepository', () {
    test('getCards returns a list of card paths', () async {
      final cards = await assetCardRepository.getCards();
      expect(cards, isA<List<String>>());
      expect(cards.length, greaterThan(0)); // Verifica se a lista não está vazia
    });

    test('getCardBack returns the correct card back image path', () async {
      final cardBack = await assetCardRepository.getCardBack();
      expect(cardBack, equals('assets/images/card_verso.png'));
    });

    test('shuffleDeck shuffles the cards', () async {
      final originalCards = await assetCardRepository.getCards();
      await assetCardRepository.shuffleDeck();
      final shuffledCards = await assetCardRepository.getCards();
      expect(originalCards, isNot(equals(shuffledCards))); // Verifica se a lista foi embaralhada
    });
  });
}