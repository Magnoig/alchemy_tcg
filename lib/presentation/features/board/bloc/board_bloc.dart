import 'package:flutter_bloc/flutter_bloc.dart';
import 'board_event.dart';
import 'board_state.dart';
import 'package:alchemy_tcg/domain/repositories/board_repository.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final BoardRepository _board;
  BoardBloc(this._board) : super(BoardState.initial()) {
    on<AddCardBoard>(_onAddCardBoard);
    on<RemoveCardBoard>(_onRemoveCardBoard);
  }

  void _onAddCardBoard(AddCardBoard event, Emitter<BoardState> emit) async {
    await _board.addCard(event.cardPath);
    
    emit(state.copyWith(cardImages: await _board.getCards()));
  }

  void _onRemoveCardBoard(RemoveCardBoard event, Emitter<BoardState> emit) async {
    await _board.removeCard(event.index);
    
    emit(state.copyWith(cardImages: await _board.getCards()));
  }
} 