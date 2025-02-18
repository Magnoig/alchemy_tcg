abstract class SpellTrapEvent {}

class AddCardBoard extends SpellTrapEvent {
  final String cardPath;

  AddCardBoard({
    required this.cardPath,
  });
}

class RemoveCardBoard extends SpellTrapEvent {
  final int index;

  RemoveCardBoard({
    required this.index,
  });
} 