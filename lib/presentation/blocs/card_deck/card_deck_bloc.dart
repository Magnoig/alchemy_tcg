import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/card_repository.dart';
import 'card_deck_event.dart';
import 'card_deck_state.dart';

class CardDeckBloc extends Bloc<CardDeckEvent, CardDeckState> {
  final CardRepository _repository;

  CardDeckBloc(this._repository) : super(CardDeckState.initial()) {
    on<RemoveTopCard>(_onRemoveTopCard);
    on<InitializeDeck>(_onInitializeDeck);
    add(InitializeDeck());
  }

  Future<void> _onInitializeDeck(InitializeDeck event, Emitter<CardDeckState> emit) async {
    await _repository.shuffleDeck();
    final cards = await _repository.getCards();
    emit(state.copyWith(cardImages: cards));
  }

  Future<void> _onRemoveTopCard(RemoveTopCard event, Emitter<CardDeckState> emit) async {
    if (state.cardImages.isNotEmpty) {
      await _repository.removeTopCard(state.cardImages);
      emit(state.copyWith(cardImages: await _repository.getCards()));
    }
  }
} 