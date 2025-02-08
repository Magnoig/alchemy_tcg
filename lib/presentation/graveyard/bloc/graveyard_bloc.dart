import 'package:alchemy_tcg/domain/repositories/card_graveyard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'graveyard_event.dart';
import 'graveyard_state.dart';

class GraveyardBloc extends Bloc<GraveyardEvent, GraveyardState> {
  final CardGraveyard graveyard;

  GraveyardBloc(this.graveyard) : super(GraveyardState.initial()) {
    on<AddCardToGraveyard>(_onAddCardToGraveyard);
    on<InitializeGraveyard>(_onInitializeGraveyard);
    on<RemoveTopCardGraveyard>(_onRemoveTopCard);
    // on<ShowGraveyard>(_onShowGraveyard);

    Future(() => add(InitializeGraveyard()));
  }

  Future<void> _onInitializeGraveyard(InitializeGraveyard event, Emitter<GraveyardState> emit) async {
    final cards = await graveyard.getCardsGraveyard();
    emit(state.copyWith(cardImages: cards));
  }

  Future<void> _onAddCardToGraveyard(AddCardToGraveyard event, Emitter<GraveyardState> emit) async {
    await graveyard.addCard(event.cardPath);
    final cards = await graveyard.getCardsGraveyard();
    emit(state.copyWith(cardImages: cards));
  }

  Future<void> _onRemoveTopCard(RemoveTopCardGraveyard event, Emitter<GraveyardState> emit) async {
    await graveyard.removeTopCard(state.cardImages);
    final cards = await graveyard.getCardsGraveyard();
    emit(state.copyWith(cardImages: cards));
  }

  // Future<void> _onShowGraveyard(ShowGraveyard event, Emitter<GraveyardState> emit) async {
  //   await graveyard.showCards();
  //   emit(state.copyWith(cardImages: await graveyard.getCardsGraveyard()));
  // }
}
