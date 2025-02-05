import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/card_hand.dart';
import 'player_hand_event.dart';
import 'player_hand_state.dart';

class PlayerHandBloc extends Bloc<PlayerHandEvent, PlayerHandState> {
  final CardHand _hand;
  PlayerHandBloc(this._hand) : super(PlayerHandState.initial()) {
    on<AddCard>(_onAddCard);
    on<RemoveCard>(_onRemoveCard);
    on<ReorderCards>(_onReorderCards);
  }

  void _onAddCard(AddCard event, Emitter<PlayerHandState> emit) async {
    await _hand.addCard(event.cardPath);
    emit(state.copyWith(cards: await _hand.getCards()));
  }

  void _onRemoveCard(RemoveCard event, Emitter<PlayerHandState> emit) async {
    await _hand.removeCard(event.cardPath);
    emit(state.copyWith(cards: await _hand.getCards()));
  }

  void _onReorderCards(ReorderCards event, Emitter<PlayerHandState> emit) async {
    await _hand.reorderCards(event.oldIndex, event.newIndex);
    emit(state.copyWith(cards: await _hand.getCards()));
  }
} 