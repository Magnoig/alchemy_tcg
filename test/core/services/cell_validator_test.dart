import 'package:flutter_test/flutter_test.dart';
import 'package:alchemy_tcg/core/constants/game_constants.dart';
import 'package:alchemy_tcg/core/validators/cell_validator.dart';

void main() {
  late CellValidator cellValidator;

  setUp(() {
    cellValidator = CellValidator();
  });

  group('CellValidator', () {
    test('isValidPosition returns true for valid positions', () {
      expect(cellValidator.isValidPosition(0, 0), isTrue);
      expect(cellValidator.isValidPosition(GameConstants.gridSize - 1, GameConstants.gridSize - 1), isTrue);
    });

    test('isValidPosition returns false for invalid positions', () {
      expect(cellValidator.isValidPosition(-1, 0), isFalse);
      expect(cellValidator.isValidPosition(0, -1), isFalse);
      expect(cellValidator.isValidPosition(GameConstants.gridSize, GameConstants.gridSize), isFalse);
    });

    test('isCentralCell returns true for central cells', () {
      expect(cellValidator.isCentralCell(GameConstants.playableStartRow, GameConstants.playableStartCol), isTrue);
      expect(cellValidator.isCentralCell(GameConstants.playableEndRow, GameConstants.playableEndCol), isTrue);
    });

    test('isCentralCell returns false for non-central cells', () {
      expect(cellValidator.isCentralCell(0, 0), isFalse);
      expect(cellValidator.isCentralCell(GameConstants.gridSize - 1, GameConstants.gridSize - 1), isFalse);
    });

    test('canAcceptCard always returns true', () {
      expect(cellValidator.canAcceptCard('path/to/card', []), isTrue);
    });
  });
}