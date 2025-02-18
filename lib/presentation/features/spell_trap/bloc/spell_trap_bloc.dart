import 'package:flutter_bloc/flutter_bloc.dart';
import 'spell_trap_event.dart';
import 'spell_trap_state.dart';
import 'package:alchemy_tcg/domain/repositories/spell_trap_repository.dart';

class SpellTrapBloc extends Bloc<SpellTrapEvent, SpellTrapState> {
  final SpellTrapRepository _board;
  SpellTrapBloc(this._board) : super(SpellTrapState.initial()) {
    on<AddCardBoard>(_onAddCardBoard);
    on<RemoveCardBoard>(_onRemoveCardBoard);
  }

  void _onAddCardBoard(AddCardBoard event, Emitter<SpellTrapState> emit) async {
    await _board.addCard(event.cardPath);
    
    emit(state.copyWith(cardImages: await _board.getCards()));
  }

  void _onRemoveCardBoard(RemoveCardBoard event, Emitter<SpellTrapState> emit) async {
    await _board.removeCard(event.index);
    
    emit(state.copyWith(cardImages: await _board.getCards()));
  }
} 