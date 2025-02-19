import 'package:alchemy_tcg/presentation/features/deck/bloc/deck_state_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/deck_repository.dart';
import 'deck_event.dart';
import 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckRepository deck;

  DeckBloc(this.deck) : super(DeckState.initial()) {
    on<AddCardDeck>(_onAddCardDeck);
    on<RemoveCardDeck>(_onRemoveCardDeck);
    on<InitializeDeck>(_onInitializeDeck);
  }

  Future<void> _onInitializeDeck(InitializeDeck event, Emitter<DeckState> emit) async {
    final currentCards = state.getCardsForCell(event.cellId);
    if (currentCards.isEmpty) {
      await deck.shuffleDeck(event.cellId);
      final cards = await deck.getCards(event.cellId);
      emit(state.copyWith(cellDecks: cards));
    }
  }

  Future<void> _onAddCardDeck(AddCardDeck event, Emitter<DeckState> emit) async {
    await deck.addCard(event.cellId, event.cardPath);
    final cards = await deck.getCards(event.cellId);
    emit(state.copyWith(cellDecks: cards));
  }

  Future<void> _onRemoveCardDeck(RemoveCardDeck event, Emitter<DeckState> emit) async {
    await deck.removeCard(event.cellId, event.index);
    emit(state.copyWith(cellDecks: await deck.getCards(event.cellId)));
  }
} 