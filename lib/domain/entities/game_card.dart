class GameCard {
  final String imagePath;
  final bool isFaceUp;

  const GameCard({
    required this.imagePath,
    this.isFaceUp = true,
  });

  GameCard copyWith({
    String? imagePath,
    bool? isFaceUp,
  }) {
    return GameCard(
      imagePath: imagePath ?? this.imagePath,
      isFaceUp: isFaceUp ?? this.isFaceUp,
    );
  }
} 