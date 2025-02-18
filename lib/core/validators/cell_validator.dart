import '../constants/game_constants.dart';

class CellValidator {
  bool isValidPosition(int row, int col) {
    return isCentralCell(row, col);
  }

  bool isCentralCell(int row, int col) {
    return GameConstants.isSpellTrapPosition(row, col);
  }

  bool canAcceptCard(String cardPath, List<String> existingCards) {
    // Por enquanto, permite colocar cartas em qualquer célula válida
    return true;
  }
} 