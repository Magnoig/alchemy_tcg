import 'package:flutter/material.dart';

import '../../domain/repositories/hand_repository.dart';
class HandRepositoryImpl implements HandRepository {
  final List<String> _hand = [
  ];

  @override
  Future<List<String>> getCards() async {
    return List.from(_hand);
  }

  @override
  Future<void> addCard(String cardPath) async {
    _hand.add(cardPath);
  }

  @override
  Future<void> removeCard(int index) async {
    if (index >= 0 && index < _hand.length) {
      _hand.removeAt(index);
    } else {
      debugPrint('Tentativa de remover carta inválida. Índice: $index, Tamanho da mão: ${_hand.length}');
    }
  }
} 