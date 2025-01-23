import 'package:flutter_bloc/flutter_bloc.dart';
import 'board_event.dart';
import 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(BoardState.initial()) {
    on<PlaceCard>(_onPlaceCard);
  }

  void _onPlaceCard(PlaceCard event, Emitter<BoardState> emit) {
    final newBoardCards = Map<String, String>.from(state.boardCards);
    newBoardCards['${event.row},${event.col}'] = event.cardPath;
    emit(state.copyWith(boardCards: newBoardCards));
  }
} 