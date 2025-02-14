import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/deck_repository.dart';
import 'card_deck_event.dart';
import 'card_deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckRepository deck;

  DeckBloc(this.deck) : super(DeckState.initial()) {
    on<AddCardDeck>(_onAddCardDeck);
    on<RemoveCardDeck>(_onRemoveCardDeck);
    on<InitializeDeck>(_onInitializeDeck);
    add(InitializeDeck());
  }

  Future<void> _onInitializeDeck(InitializeDeck event, Emitter<DeckState> emit) async {
    await deck.shuffleDeck();
    final cards = await deck.getCards();
    emit(state.copyWith(cardImages: cards));
  }

  Future<void> _onAddCardDeck(AddCardDeck event, Emitter<DeckState> emit) async {
    await deck.addCard(event.cardPath);
    final cards = await deck.getCards();
    emit(state.copyWith(cardImages: cards));
  }

  Future<void> _onRemoveCardDeck(RemoveCardDeck event, Emitter<DeckState> emit) async {
    await deck.removeCard(event.index);
    emit(state.copyWith(cardImages: await deck.getCards()));
  }
} 