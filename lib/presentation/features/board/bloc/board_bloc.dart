import 'package:flutter_bloc/flutter_bloc.dart';
import 'board_event.dart';
import 'board_state.dart';
import 'package:alchemy_tcg/domain/repositories/board_repository.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final BoardRepository _board;
  BoardBloc(this._board) : super(BoardState.initial()) {
    on<PlaceCard>(_onPlaceCard);
    on<RemoveCard>(_onRemoveCard);
  }

  void _onPlaceCard(PlaceCard event, Emitter<BoardState> emit) async {
    await _board.placeCard(event.cardPath, event.row, event.col);
    
    emit(state.copyWith(boardCards: await _board.getBoardCards()));
  }

  void _onRemoveCard(RemoveCard event, Emitter<BoardState> emit) async {
    await _board.removeCard(event.row, event.col);
    
    emit(state.copyWith(boardCards: await _board.getBoardCards()));
  }
} 