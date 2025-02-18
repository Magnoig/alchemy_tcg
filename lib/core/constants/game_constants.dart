class GameConstants {
  static const int gridRows = 5;
  static const int gridCols = 7;
  
  static const int spellTrapStartRow = 4;
  static const int spellTrapStartCol = 1;
  static const int spellTrapEndRow = 4;
  static const int spellTrapEndCol = 5;

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

  static bool isSpellTrapPosition(int row, int col) {
    return row >= spellTrapStartRow && 
           row <= spellTrapEndRow && 
           col >= spellTrapStartCol && 
           col <= spellTrapEndCol;
  }

  static String getCellType(int row, int col) {
    if (isDeckPosition(row, col)) {
      return 'deck';
    } else if (isGraveyardPosition(row, col)) {
      return 'graveyard';
    } else if (isSpellTrapPosition(row, col)) {
      return 'spell_trap';
    }
    return 'empty';
  }
  
} 