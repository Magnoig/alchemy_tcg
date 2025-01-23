class CellValidator {
  bool isValidPosition(int row, int col) {
    return row >= 0 && row < 5 && col >= 0 && col < 5;
  }

  bool isCentralCell(int row, int col) {
    return row >= 1 && row <= 5 && col >= 1 && col <= 5;
  }

  bool canAcceptCard(String cardPath, List<String> existingCards) {
    // Aqui você pode adicionar regras específicas do jogo
    // Por exemplo, verificar se a carta pode ser colocada em cima de outras
    return true;
  }
} 