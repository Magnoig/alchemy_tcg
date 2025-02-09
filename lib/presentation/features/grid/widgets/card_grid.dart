import 'package:alchemy_tcg/domain/interfaces/card_zoom_handler.dart';
import 'package:alchemy_tcg/domain/interfaces/grid_layout_manager.dart';
import 'package:alchemy_tcg/presentation/features/grid/managers/grid_scroll_manager.dart';
import 'package:alchemy_tcg/presentation/features/hand/bloc/player_hand_bloc.dart';
import 'package:flutter/material.dart';
import '../../hand/widget/player_hand.dart';

class CardGrid extends StatefulWidget {
  final CardZoomHandler zoomHandler;
  final GridLayoutManager layoutManager;
  final GridScrollManager scrollManager;
  final PlayerHandBloc playerHandBloc;
  
  const CardGrid({
    required this.zoomHandler,
    required this.layoutManager,
    required this.scrollManager,
    required this.playerHandBloc,
    super.key,
  });
  
  @override
  CardGridState createState() => CardGridState();
}

class CardGridState extends State<CardGrid> {
  late final PlayerHandBloc _playerHandBloc;
  
  @override
  void initState() {
    super.initState();
    widget.scrollManager.initializeScroll();
    _playerHandBloc = widget.playerHandBloc;
  }
  
  @override
  void dispose() {
    widget.scrollManager.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('TCG')),
      body: Column(
        children: [
          Expanded(
            child: widget.layoutManager.buildGrid(MediaQuery.of(context).size.width),
          ),
          PlayerHand(
            onShowZoom: widget.zoomHandler.showCardZoom,
            playerHandBloc: _playerHandBloc,
          ),
        ],
      ),
    );
  }
}