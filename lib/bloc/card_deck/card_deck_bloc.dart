import 'package:flutter_bloc/flutter_bloc.dart';
import '../../interfaces/card_repository.dart';
import 'card_deck_event.dart';
import 'card_deck_state.dart';

class CardDeckBloc extends Bloc<CardDeckEvent, CardDeckState> {
  final CardRepository _repository;

  CardDeckBloc(this._repository) : super(CardDeckState.initial()) {
    on<RemoveTopCard>(_onRemoveTopCard);
    on<InitializeDeck>(_onInitializeDeck);
    _initialize();
  }

  Future<void> _initialize() async {
    add(InitializeDeck());
  }

  Future<void> _onInitializeDeck(InitializeDeck event, Emitter<CardDeckState> emit) async {
    final cards = await _repository.getCards();
    await _repository.shuffleDeck();
    emit(state.copyWith(cardImages: cards));
  }

  void _onRemoveTopCard(RemoveTopCard event, Emitter<CardDeckState> emit) {
    if (state.cardImages.isNotEmpty) {
      final newCards = List<String>.from(state.cardImages)..removeLast();
      emit(state.copyWith(cardImages: newCards));
    }
  }
} 