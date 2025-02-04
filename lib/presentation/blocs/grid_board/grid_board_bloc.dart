import 'package:flutter_bloc/flutter_bloc.dart';
import 'grid_board_event.dart';
import 'grid_board_state.dart';

class GridBoardBloc extends Bloc<GridBoardEvent, GridBoardState> {
  GridBoardBloc() : super(GridBoardState.initial()) {
    on<StartDraggingCard>(_onStartDraggingCard);
    on<StopDraggingCard>(_onStopDraggingCard);
    on<HoverOverCell>(_onHoverOverCell);
    on<LeaveCell>(_onLeaveCell);
  }

  void _onStartDraggingCard(StartDraggingCard event, Emitter<GridBoardState> emit) {
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

    emit(GridBoardState(
      cellStates: newCellStates,
      validPositions: validPositions,
    ));
  }

  void _onStopDraggingCard(StopDraggingCard event, Emitter<GridBoardState> emit) {
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

    emit(GridBoardState(
      cellStates: newCellStates,
      validPositions: {},
    ));
  }

  void _onHoverOverCell(HoverOverCell event, Emitter<GridBoardState> emit) {
    if (event.row < 0 || event.row >= 5 || event.col < 0 || event.col >= 5) return;

    final newCellStates = List<List<CellState>>.from(
      state.cellStates.map((row) => List<CellState>.from(row)),
    );

    if (state.validPositions.contains('${event.row},${event.col}')) {
      newCellStates[event.row][event.col] = CellState.highlighted;
    }

    emit(GridBoardState(
      cellStates: newCellStates,
      validPositions: state.validPositions,
    ));
  }

  void _onLeaveCell(LeaveCell event, Emitter<GridBoardState> emit) {
    if (event.row < 0 || event.row >= 5 || event.col < 0 || event.col >= 5) return;

    final newCellStates = List<List<CellState>>.from(
      state.cellStates.map((row) => List<CellState>.from(row)),
    );

    if (state.validPositions.contains('${event.row},${event.col}')) {
      newCellStates[event.row][event.col] = CellState.valid;
    } else {
      newCellStates[event.row][event.col] = CellState.empty;
    }

    emit(GridBoardState(
      cellStates: newCellStates,
      validPositions: state.validPositions,
    ));
  }
} 