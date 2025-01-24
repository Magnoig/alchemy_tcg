import 'package:flutter_test/flutter_test.dart';
import 'package:alchemy_tcg/core/constants/game_constants.dart';

void main() {
  group('GameConstants', () {
    test('isDeckPosition returns true for deck position', () {
      expect(GameConstants.isDeckPosition(6, 0), isTrue);
    });

    test('isDeckPosition returns false for non-deck position', () {
      expect(GameConstants.isDeckPosition(5, 0), isFalse);
      expect(GameConstants.isDeckPosition(6, 1), isFalse);
    });

    test('isPlayablePosition returns true for playable position', () {
      expect(GameConstants.isPlayablePosition(3, 2), isTrue);
    });

    test('isPlayablePosition returns false for non-playable position', () {
      expect(GameConstants.isPlayablePosition(0, 0), isFalse);
      expect(GameConstants.isPlayablePosition(6, 0), isFalse);
      expect(GameConstants.isPlayablePosition(1, 6), isFalse);
    });
  });
}