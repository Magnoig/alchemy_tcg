import '../constants/game_constants.dart';

class CellValidator {
  bool isValidPosition(int row, int col) {
    return row >= 0 && row < GameConstants.gridRows && 
           col >= 0 && col < GameConstants.gridCols;
  }

  bool isCentralCell(int row, int col) {
    // Área jogável é 5x5 no centro do tabuleiro 7x7
    return row >= GameConstants.playableStartRow && 
           row <= GameConstants.playableEndRow && 
           col >= GameConstants.playableStartCol && 
           col <= GameConstants.playableEndCol;
  }

  bool canAcceptCard(String cardPath, List<String> existingCards) {
    // Por enquanto, permite colocar cartas em qualquer célula válida
    return true;
  }
} 