import 'package:alchemy_tcg/domain/repositories/spell_trap_repository.dart';
class SpellTrapRepositoryImpl extends SpellTrapRepository {
  final List<String> _boardCards = [];

  @override
  Future<List<String>> getCards() async {
    return List.from(_boardCards);
  }

  @override
  Future<void> addCard(String cardPath) async {
    _boardCards.add(cardPath);
  }

  @override
  Future<void> removeCard(int index) async {
    _boardCards.removeAt(index);
  }
}