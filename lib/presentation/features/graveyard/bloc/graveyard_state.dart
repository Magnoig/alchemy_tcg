import 'package:flutter/foundation.dart';

class GraveyardState {
  final Map<String, List<String>> graveyardCards;

  GraveyardState({required this.graveyardCards});

  factory GraveyardState.initial() {
    return GraveyardState(graveyardCards: {});
  }

  GraveyardState copyWith({
    Map<String, List<String>>? graveyardCards,
  }) {
    return GraveyardState(
      graveyardCards: graveyardCards ?? this.graveyardCards,
    );
  }

  String? getTopCard(String position) {
    final stack = graveyardCards[position];
    return (stack?.isNotEmpty == true) ? stack!.last : null;
  }

  String? getCardBelowTop(String position) {
    final stack = graveyardCards[position];
    return (stack != null && stack.length > 1) ? stack[stack.length - 2] : null;
  }
} 