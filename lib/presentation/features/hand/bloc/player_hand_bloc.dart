import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/hand_repository.dart';
import 'player_hand_event.dart';
import 'player_hand_state.dart';

class PlayerHandBloc extends Bloc<PlayerHandEvent, PlayerHandState> {
  final HandRepository _hand;
  
  PlayerHandBloc(this._hand) : super(PlayerHandState.initial()) {
    on<AddCard>((event, emit) async {
      await _hand.addCard(event.cardPath);
      final cards = await _hand.getCards();
      final newState = state.copyWith(cards: cards);
      emit(newState);
    });

    on<RemoveCard>((event, emit) async {
    await _hand.removeCard(event.cardPath);
      final cards = await _hand.getCards();
      emit(state.copyWith(cards: cards));
    });

    on<ReorderCards>((event, emit) async {
      await _hand.reorderCards(event.oldIndex, event.newIndex);
      final cards = await _hand.getCards();
      emit(state.copyWith(cards: cards));
    });
  }
}
