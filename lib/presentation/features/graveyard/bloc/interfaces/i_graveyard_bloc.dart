import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_event.dart';
import 'package:alchemy_tcg/presentation/features/graveyard/bloc/graveyard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IGraveyardBloc extends StateStreamable<GraveyardState> {
  @override
  GraveyardState get state;
  void add(GraveyardEvent event);
}