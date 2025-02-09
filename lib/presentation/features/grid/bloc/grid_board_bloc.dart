import 'package:alchemy_tcg/domain/services/grid_board_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'grid_board_event.dart';
import 'grid_board_state.dart';

class GridBoardBloc extends Bloc<GridBoardEvent, GridBoardState> {
  final GridBoardService _cardGridService;

  GridBoardBloc(GridBoardService cardGridService)
      : _cardGridService = cardGridService,
        super(GridBoardState.initial()) {
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
      validPositions: _cardGridService.validPositions,
    ));
  }

  void _onHoverOverCell(HoverOverCell event, Emitter<GridBoardState> emit) async {

    await _cardGridService.hoverOverCell(event.row, event.col);
    
    emit(GridBoardState(
      cellStates: _cardGridService.newCellStates,
      validPositions: _cardGridService.validPositions,
    ));
  }

  void _onLeaveCell(LeaveCell event, Emitter<GridBoardState> emit) async {
    await _cardGridService.leaveCell(event.row, event.col);

    emit(GridBoardState(
      cellStates: _cardGridService.newCellStates,
      validPositions: _cardGridService.validPositions,
    ));
  }
} 