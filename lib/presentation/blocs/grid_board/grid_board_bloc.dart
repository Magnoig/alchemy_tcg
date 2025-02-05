import 'package:flutter_bloc/flutter_bloc.dart';
import 'grid_board_event.dart';
import 'grid_board_state.dart';
import '../../../data/services/grid_board_service.dart';

class GridBoardBloc extends Bloc<GridBoardEvent, GridBoardState> {
  final GridBoardService _cardGridService;

  GridBoardBloc(this._cardGridService) : super(GridBoardState.initial()) {
    on<StartDraggingCard>(_onStartDraggingCard);
    on<StopDraggingCard>(_onStopDraggingCard);
    on<HoverOverCell>(_onHoverOverCell);
    on<LeaveCell>(_onLeaveCell);
  }

  void _onStartDraggingCard(StartDraggingCard event, Emitter<GridBoardState> emit) async {
    await _cardGridService.startDraggingCard(event.cardPath);

    emit(GridBoardState(
      cellStates: _cardGridService.newCellStates,
      validPositions: _cardGridService.validPositions,
    ));
  }

  void _onStopDraggingCard(StopDraggingCard event, Emitter<GridBoardState> emit) async {
    await _cardGridService.stopDraggingCard();

    emit(GridBoardState(
      cellStates: _cardGridService.newCellStates,
      validPositions: {},
    ));
  }

  void _onHoverOverCell(HoverOverCell event, Emitter<GridBoardState> emit) async {

    await _cardGridService.hoverOverCell(event.row, event.col);
    
    emit(GridBoardState(
      cellStates: _cardGridService.newCellStates,
      validPositions: _cardGridService.validPositions,
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