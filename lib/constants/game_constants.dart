class GameConstants {
  // Layout
  static const double handHeight = 100.0;
  static const double cardAspectRatio = 1.4;
  static const int gridSize = 7;
  static const int centralGridSize = 5;
  static const double cardBorderWidth = 2.0;

  // Animations
  static const Duration scrollDuration = Duration(milliseconds: 500);
  static const Duration cardAnimationDuration = Duration(milliseconds: 300);
  static const Duration hoverAnimationDuration = Duration(milliseconds: 200);

  // Card sizes
  static const double handCardHeight = 80.0;
  static const double zoomWidthFactor = 0.7;
  static const double zoomHeightFactor = 0.7;
  static const double deckOverflowFactor = 0.65;

  // Grid positions
  static const int deckRow = 6;
  static const int deckCol = 0;
  static const int centralGridStart = 1;
  static const int centralGridEnd = 5;
} 