import 'package:flutter_bloc/flutter_bloc.dart';
import 'card_grid_event.dart';
import 'card_grid_state.dart';

class CardGridBloc extends Bloc<CardGridEvent, CardGridState> {
  CardGridBloc() : super(CardGridState(List.generate(5, (_) => List.filled(5, '')))) {
    on<InitializeGrid>((event, emit) {
      // Inicialize a grade de cartas
      emit(CardGridState(List.generate(5, (_) => List.filled(5, 'Carta'))));
    });
  }
} 