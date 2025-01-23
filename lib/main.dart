import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/card_grid_bloc.dart';
import 'widgets/card_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo de Cartas',
      home: BlocProvider(
        create: (context) => CardGridBloc(),
        child: CardGrid(),
      ),
    );
  }
}