import 'package:alchemy_tcg/domain/repositories/board_repository.dart';
class BoardRepositoryImpl extends BoardRepository {
  final Map<String, List<String>> _boardCards = {};

  @override
  Future<Map<String, List<String>>> getBoardCards() async {
    return Map.from(_boardCards);
  }

  @override
  Future<void> placeCard(String cardPath, int row, int col) async {
    final position = '$row,$col';
    if (!_boardCards.containsKey(position)) {
      _boardCards[position] = [];
    }
    _boardCards[position]!.add(cardPath);
  }

  @override
  Future<void> removeCard(int row, int col) async {
    final position = '$row,$col';
    if (_boardCards.containsKey(position) && _boardCards[position]!.isNotEmpty) {
      _boardCards[position]!.removeLast();
      if (_boardCards[position]!.isEmpty) {
        _boardCards.remove(position);
      }
    }
  }
}