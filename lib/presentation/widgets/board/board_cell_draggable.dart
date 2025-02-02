import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/board/board_bloc.dart';
import '../../blocs/board/board_event.dart';
import 'package:alchemy_tcg/core/di/service_locator.dart';
import 'package:alchemy_tcg/domain/repositories/card_repository.dart';

class BoardCellDraggable extends StatelessWidget {
  final String cardPath;
  final String? cardBelow;
  final double cellSize;
  final int row;
  final int col;
  final Function(BuildContext, String) onShowZoom;
  final Function(String) onCardRemoved;

  const BoardCellDraggable({
    super.key,
    required this.cardPath,
    required this.cardBelow,
    required this.cellSize,
    required this.row,
    required this.col,
    required this.onShowZoom,
    required this.onCardRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onLongPress: () => onShowZoom(context, cardPath),
        child: Draggable<String>(
          data: cardPath,
          onDragCompleted: () {
            context.read<BoardBloc>().add(RemoveCard(
              row: row,
              col: col,
            ));
            onCardRemoved(cardPath);
          },
          feedback: Image.asset(
            cardPath,
            width: cellSize,
            height: cellSize,
            fit: BoxFit.contain,
          ),
          childWhenDragging: cardBelow != null
              ? FutureBuilder<String?>(
                  future: getIt<CardRepository>().getCardBack(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Icon(Icons.error));
                    } else {
                      return Image.asset(
                        snapshot.data ?? '', // Use o caminho da imagem
                        fit: BoxFit.contain,
                      );
                    }
                  },
                )
              : Container(),
          child: Image.asset(
            cardPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
} 