class GameConstants {
  static const int gridRows = 5;
  static const int gridCols = 7;
  
  static const int playableStartRow = 0;
  static const int playableStartCol = 0;
  static const int playableEndRow = gridRows;
  static const int playableEndCol = gridCols;

  static const int deckRow = 4;
  static const int deckCol = 6;

  static const int graveyardRow = 3;
  static const int graveyardCol = 6;

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

  static bool isGraveyardPosition(int row, int col) {
    return row == graveyardRow && col == graveyardCol;
  }

  static bool isPlayablePosition(int row, int col) {
    return row >= playableStartRow && 
           row <= playableEndRow && 
           col >= playableStartCol && 
           col <= playableEndCol;
  }

  static String getCellType(int row, int col) {
    if (row == deckRow && col == deckCol) {
      return 'deck';
    } else if (row == graveyardRow && col == graveyardCol) {
      return 'graveyard';
    } else if (row >= playableStartRow && row <= playableEndRow) {
      return 'playable';
    }
    return 'empty';
  }
  
} 