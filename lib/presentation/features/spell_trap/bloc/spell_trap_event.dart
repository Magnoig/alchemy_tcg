abstract class SpellTrapEvent {}

class AddCardSpellTrap extends SpellTrapEvent {
  final String cellId;
  final String cardPath;

  AddCardSpellTrap({
    required this.cellId,
    required this.cardPath,
  });
}

class RemoveCardSpellTrap extends SpellTrapEvent {
  final String cellId;
  final int index;

  RemoveCardSpellTrap({
    required this.cellId,
    required this.index,
  });
} 