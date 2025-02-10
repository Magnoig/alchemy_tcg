import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/deck_repository.dart';
import 'card_deck_event.dart';
import 'card_deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckRepository _repository;

  DeckBloc(this._repository) : super(DeckState.initial()) {
    on<RemoveTopCard>(_onRemoveTopCard);
    on<InitializeDeck>(_onInitializeDeck);
    add(InitializeDeck());
  }

  Future<void> _onInitializeDeck(InitializeDeck event, Emitter<DeckState> emit) async {
    await _repository.shuffleDeck();
    final cards = await _repository.getCards();
    emit(state.copyWith(cardImages: cards));
  }

  Future<void> _onRemoveTopCard(RemoveTopCard event, Emitter<DeckState> emit) async {
    await _repository.removeTopCard(state.cardImages);
    emit(state.copyWith(cardImages: await _repository.getCards()));
  }
} 