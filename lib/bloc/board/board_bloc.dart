import 'package:flutter_bloc/flutter_bloc.dart';
import 'board_event.dart';
import 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(BoardState.initial()) {
    on<PlaceCard>(_onPlaceCard);
    on<RemoveCard>(_onRemoveCard);
  }

  void _onPlaceCard(PlaceCard event, Emitter<BoardState> emit) {
    final position = '${event.row},${event.col}';
    final newBoardCards = Map<String, List<String>>.from(state.boardCards);
    
    // Inicializa a pilha se não existir
    if (!newBoardCards.containsKey(position)) {
      newBoardCards[position] = [];
    }
    
    // Adiciona a carta no topo da pilha
    newBoardCards[position]!.add(event.cardPath);
    
    emit(state.copyWith(boardCards: newBoardCards));
  }

  void _onRemoveCard(RemoveCard event, Emitter<BoardState> emit) {
    final position = '${event.row},${event.col}';
    final newBoardCards = Map<String, List<String>>.from(state.boardCards);
    
    if (newBoardCards.containsKey(position) && newBoardCards[position]!.isNotEmpty) {
      // Remove apenas a carta do topo
      newBoardCards[position]!.removeLast();
      
      // Remove a posição se não houver mais cartas
      if (newBoardCards[position]!.isEmpty) {
        newBoardCards.remove(position);
      }
    }
    
    emit(state.copyWith(boardCards: newBoardCards));
  }
} 