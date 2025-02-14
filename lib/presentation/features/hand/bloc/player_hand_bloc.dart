import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/hand_repository.dart';
import 'player_hand_event.dart';
import 'player_hand_state.dart';

class PlayerHandBloc extends Bloc<PlayerHandEvent, PlayerHandState> {
  final HandRepository _hand;
  
  PlayerHandBloc(this._hand) : super(PlayerHandState.initial()) {
    on<AddCardHand>((event, emit) async {
      await _hand.addCard(event.cardPath);
      final cards = await _hand.getCards();
      final newState = state.copyWith(cards: cards);
      emit(newState);
    });

    on<RemoveCardHand>((event, emit) async {
    await _hand.removeCard(event.index);
      final cards = await _hand.getCards();
      emit(state.copyWith(cards: cards));
    });

  }
}
