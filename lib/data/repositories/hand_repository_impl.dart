import '../../domain/repositories/hand_repository.dart';
class HandRepositoryImpl implements HandRepository {
  final List<String> _cards = [
  ];

  @override
  Future<List<String>> getCards() async {
    return List.from(_cards);
  }

  @override
  Future<void> addCard(String cardPath) async {
    _cards.add(cardPath);
  }

  @override
  Future<void> removeCard(int index) async {
    _cards.removeAt(index);
  }

} 