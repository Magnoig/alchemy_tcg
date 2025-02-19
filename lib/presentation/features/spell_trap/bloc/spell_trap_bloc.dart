import 'package:flutter_bloc/flutter_bloc.dart';
import 'spell_trap_event.dart';
import 'spell_trap_state.dart';
import 'package:alchemy_tcg/domain/repositories/spell_trap_repository.dart';

class SpellTrapBloc extends Bloc<SpellTrapEvent, SpellTrapState> {
  final SpellTrapRepository _spellTrap;
  SpellTrapBloc(this._spellTrap) : super(SpellTrapState.initial()) {
    on<AddCardSpellTrap>(_onAddCardSpellTrap);
    on<RemoveCardSpellTrap>(_onRemoveCardSpellTrap);
  }

  void _onAddCardSpellTrap(AddCardSpellTrap event, Emitter<SpellTrapState> emit) async {
    await _spellTrap.addCard(event.cellId, event.cardPath);
    
    emit(state.copyWith(spellTrapCards: await _spellTrap.getCards()));
  }

  void _onRemoveCardSpellTrap(RemoveCardSpellTrap event, Emitter<SpellTrapState> emit) async {
    await _spellTrap.removeCard(event.cellId, event.index);
    
    emit(state.copyWith(spellTrapCards: await _spellTrap.getCards()));
  }
} 