import 'package:flutter_test/flutter_test.dart';
import 'card_repository_scenarios.dart';


void main() {
  late CardRepositoryScenarios cardRepository;

  setUp(() {
    cardRepository = CardRepositoryScenarios(); // Inicializa a classe concreta antes de cada teste
  });

  group('CardRepository Tests', () {
    test('getCards returns an empty list initially', () async {
      final cards = await cardRepository.getCards();
      expect(cards, isEmpty); // Verifica se a lista está vazia inicialmente
    });

    test('addCard adds a card to the repository', () async {
      final cardPath = 'assets/images/card.png';
      await cardRepository.addCard(cardPath);
      final cards = await cardRepository.getCards();
      expect(cards, contains(cardPath)); // Verifica se o cartão foi adicionado
    });

    test('removeCard removes a card from the repository', () async {
      final cardPath = 'assets/images/card.png';
      await cardRepository.addCard(cardPath);
      await cardRepository.removeCard(cardPath);
      final cards = await cardRepository.getCards();
      expect(cards, isNot(contains(cardPath))); // Verifica se o cartão foi removido
    });

    test('shuffleDeck shuffles the cards', () async {
      final card1 = 'assets/images/card1.png'; // Usando String para corresponder à assinatura
      final card2 = 'assets/images/card2.png';
      final card3 = 'assets/images/card3.png';
      final card4 = 'assets/images/card4.png';
      final card5 = 'assets/images/card5.png';
      
      await cardRepository.addCard(card1);
      await cardRepository.addCard(card2);
      await cardRepository.addCard(card3);
      await cardRepository.addCard(card4);
      await cardRepository.addCard(card5);
      
      final originalCards = (await cardRepository.getCards()).toList();
      await cardRepository.shuffleDeck();
      final shuffledCards = await cardRepository.getCards();
      // Verifica se a lista embaralhada não é igual à lista original
      expect(originalCards, isNot(equals(shuffledCards))); 
    });
  });
}