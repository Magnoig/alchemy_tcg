import 'package:flutter_test/flutter_test.dart';
import 'package:alchemy_tcg/domain/entities/card.dart';
void main() {
  group('Card', () {
    test('Card constructor initializes properties correctly', () {
      final card = Card(imagePath: 'assets/images/card.png', isFaceUp: false);
      expect(card.imagePath, equals('assets/images/card.png'));
      expect(card.isFaceUp, isFalse);
    });

    test('copyWith creates a copy with updated properties', () {
      final card = Card(imagePath: 'assets/images/card.png', isFaceUp: false);
      final updatedCard = card.copyWith(isFaceUp: true);

      expect(updatedCard.imagePath, equals(card.imagePath)); // imagePath deve permanecer o mesmo
      expect(updatedCard.isFaceUp, isTrue); // isFaceUp deve ser atualizado
    });

    test('copyWith returns a new instance', () {
      final card = Card(imagePath: 'assets/images/card.png', isFaceUp: false);
      final updatedCard = card.copyWith(isFaceUp: true);

      expect(card, isNot(equals(updatedCard))); // As instâncias devem ser diferentes
    });
  });
}