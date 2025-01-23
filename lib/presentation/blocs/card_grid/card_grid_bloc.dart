import 'package:flutter_bloc/flutter_bloc.dart';
import 'card_grid_event.dart';
import 'card_grid_state.dart';

class CardGridBloc extends Bloc<CardGridEvent, CardGridState> {
  CardGridBloc() : super(CardGridState.initial()) {
    on<StartDraggingCard>(_onStartDraggingCard);
    on<StopDraggingCard>(_onStopDraggingCard);
    on<HoverOverCell>(_onHoverOverCell);
    on<LeaveCell>(_onLeaveCell);
  }

  void _onStartDraggingCard(StartDraggingCard event, Emitter<CardGridState> emit) {
    final validPositions = <String>{};
    final newCellStates = List<List<CellState>>.from(
      state.cellStates.map((row) => List<CellState>.from(row)),
    );

    for (int row = 0; row < 5; row++) {
      for (int col = 0; col < 5; col++) {
        if (state.cellStates[row][col] == CellState.empty) {
          validPositions.add('$row,$col');
          newCellStates[row][col] = CellState.valid;
        }
      }
    }

    emit(CardGridState(
      cellStates: newCellStates,
      validPositions: validPositions,
    ));
  }

  void _onStopDraggingCard(StopDraggingCard event, Emitter<CardGridState> emit) {
    final newCellStates = List<List<CellState>>.from(
      state.cellStates.map((row) => List<CellState>.from(row)),
    );

    for (int row = 0; row < 5; row++) {
      for (int col = 0; col < 5; col++) {
        if (newCellStates[row][col] != CellState.empty) {
          newCellStates[row][col] = CellState.empty;
        }
      }
    }

    emit(CardGridState(
      cellStates: newCellStates,
      validPositions: {},
    ));
  }

  void _onHoverOverCell(HoverOverCell event, Emitter<CardGridState> emit) {
    if (event.row < 0 || event.row >= 5 || event.col < 0 || event.col >= 5) return;

    final newCellStates = List<List<CellState>>.from(
      state.cellStates.map((row) => List<CellState>.from(row)),
    );

    if (state.validPositions.contains('${event.row},${event.col}')) {
      newCellStates[event.row][event.col] = CellState.highlighted;
    }

    emit(CardGridState(
      cellStates: newCellStates,
      validPositions: state.validPositions,
    ));
  }

  void _onLeaveCell(LeaveCell event, Emitter<CardGridState> emit) {
    if (event.row < 0 || event.row >= 5 || event.col < 0 || event.col >= 5) return;

    final newCellStates = List<List<CellState>>.from(
      state.cellStates.map((row) => List<CellState>.from(row)),
    );

    if (state.validPositions.contains('${event.row},${event.col}')) {
      newCellStates[event.row][event.col] = CellState.valid;
    } else {
      newCellStates[event.row][event.col] = CellState.empty;
    }

    emit(CardGridState(
      cellStates: newCellStates,
      validPositions: state.validPositions,
    ));
  }
} 