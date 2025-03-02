import 'package:alchemy_tcg/domain/repositories/spell_trap_repository.dart';

class SpellTrapRepositoryImpl extends SpellTrapRepository {
  final Map<String, List<String>> _spellTrapCards = {}; 

  @override
  Future<Map<String, List<String>>> getCards() async {
    return Map.from(_spellTrapCards);
  }

  @override
  Future<void> addCard(String cellId, String cardPath) async {
    if (!_spellTrapCards.containsKey(cellId)) {
      _spellTrapCards[cellId] = []; 
    }
    _spellTrapCards[cellId]!.add(cardPath);
  }

  @override
  Future<void> removeCard(String cellId, int index) async {
    if (_spellTrapCards.containsKey(cellId)) {
      List<String> cards = _spellTrapCards[cellId]!;

      if (index >= 0 && index < cards.length) {
        cards.removeAt(index);
      }

      if (cards.isEmpty) {
        _spellTrapCards.remove(cellId);
      }
    }
  }
}