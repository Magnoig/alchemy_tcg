class Card {
  final String imagePath;
  final bool isFaceUp;

  const Card({
    required this.imagePath,
    this.isFaceUp = true,
  });

  Card copyWith({
    String? imagePath,
    bool? isFaceUp,
  }) {
    return Card(
      imagePath: imagePath ?? this.imagePath,
      isFaceUp: isFaceUp ?? this.isFaceUp,
    );
  }
} 