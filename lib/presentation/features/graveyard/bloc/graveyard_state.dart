import 'package:flutter/foundation.dart';

class GraveyardState {
  final List<String> cardImages;

  GraveyardState({required this.cardImages});

  factory GraveyardState.initial() {
    return GraveyardState(cardImages: []);
  }

  GraveyardState copyWith({
    List<String>? cardImages,
  }) {
    return GraveyardState(
      cardImages: cardImages ?? List.from(this.cardImages),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GraveyardState &&
          runtimeType == other.runtimeType &&
          listEquals(cardImages, other.cardImages);

  @override
  int get hashCode => cardImages.hashCode;

  String? getCardBelowTop() {
    if (cardImages.length < 2) return null;
    return cardImages[cardImages.length - 2];
  }
} 