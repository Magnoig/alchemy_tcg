class GameConstants {
  static const int gridSize = 7;
  static const int playableGridSize = 5;
  static const int playableStartRow = 1;
  static const int playableStartCol = 1;
  static const int playableEndRow = 5;
  static const int playableEndCol = 5;
  static const int deckRow = 6;
  static const int deckCol = 0;
  static const double cardAspectRatio = 0.7;
  static const double deckOverflowFactor = 0.65;
  static const double handHeight = 150.0;
  static const double handCardHeight = 120.0;
  static const double zoomWidthFactor = 0.7;
  static const double zoomHeightFactor = 0.8;
  static const Duration scrollDuration = Duration(milliseconds: 500);

  static bool isDeckPosition(int row, int col) {
    return row == deckRow && col == deckCol;
  }

  static bool isPlayablePosition(int row, int col) {
    return row >= playableStartRow && 
           row <= playableEndRow && 
           col >= playableStartCol && 
           col <= playableEndCol;
  }
} 