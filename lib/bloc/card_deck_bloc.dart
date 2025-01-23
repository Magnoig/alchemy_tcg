import 'package:flutter_bloc/flutter_bloc.dart';
import 'card_deck_event.dart';
import 'card_deck_state.dart';

class CardDeckBloc extends Bloc<CardDeckEvent, CardDeckState> {
  CardDeckBloc() : super(CardDeckState.initial()) {
    on<RemoveTopCard>(_onRemoveTopCard);
  }

  void _onRemoveTopCard(RemoveTopCard event, Emitter<CardDeckState> emit) {
    if (state.cardImages.isNotEmpty) {
      final newCards = List<String>.from(state.cardImages)..removeLast();
      emit(state.copyWith(cardImages: newCards));
    }
  }
} 