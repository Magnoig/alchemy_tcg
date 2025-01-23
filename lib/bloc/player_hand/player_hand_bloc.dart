import 'package:flutter_bloc/flutter_bloc.dart';
import 'player_hand_event.dart';
import 'player_hand_state.dart';

class PlayerHandBloc extends Bloc<PlayerHandEvent, PlayerHandState> {
  PlayerHandBloc() : super(PlayerHandState.initial()) {
    on<AddCard>(_onAddCard);
    on<RemoveCard>(_onRemoveCard);
    on<ReorderCards>(_onReorderCards);
  }

  void _onAddCard(AddCard event, Emitter<PlayerHandState> emit) {
    final newCards = List<String>.from(state.cards)..add(event.cardPath);
    emit(state.copyWith(cards: newCards));
  }

  void _onRemoveCard(RemoveCard event, Emitter<PlayerHandState> emit) {
    final newCards = List<String>.from(state.cards)..remove(event.cardPath);
    emit(state.copyWith(cards: newCards));
  }

  void _onReorderCards(ReorderCards event, Emitter<PlayerHandState> emit) {
    final newCards = List<String>.from(state.cards);
    final int newIndex = event.oldIndex < event.newIndex
        ? event.newIndex - 1
        : event.newIndex;
    final item = newCards.removeAt(event.oldIndex);
    newCards.insert(newIndex, item);
    emit(state.copyWith(cards: newCards));
  }
} 