import 'package:alchemy_tcg/domain/repositories/graveyard_repository.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/interfaces/i_graveyard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'graveyard_event.dart';
import 'graveyard_state.dart';

class GraveyardBloc extends Bloc<GraveyardEvent, GraveyardState> implements IGraveyardBloc {
  final GraveyardRepository graveyard;

  GraveyardBloc(this.graveyard) : super(GraveyardState.initial()) {
    on<AddCardGraveyard>(_onAddCardGraveyard);
    on<InitializeGraveyard>(_onInitializeGraveyard);
    on<RemoveCardGraveyard>(_onRemoveCard);

    Future(() => add(InitializeGraveyard()));
  }

  Future<void> _onInitializeGraveyard(InitializeGraveyard event, Emitter<GraveyardState> emit) async {
    final cards = await graveyard.getCardsGraveyard();
    emit(state.copyWith(cardImages: cards));
  }

  Future<void> _onAddCardGraveyard(AddCardGraveyard event, Emitter<GraveyardState> emit) async {
    await graveyard.addCard(event.cardPath);
    final cards = await graveyard.getCardsGraveyard();
    emit(state.copyWith(cardImages: cards));
  }

  Future<void> _onRemoveCard(RemoveCardGraveyard event, Emitter<GraveyardState> emit) async {
    await graveyard.removeCard(event.index);
    final cards = await graveyard.getCardsGraveyard();
    emit(state.copyWith(cardImages: cards));
  }
}