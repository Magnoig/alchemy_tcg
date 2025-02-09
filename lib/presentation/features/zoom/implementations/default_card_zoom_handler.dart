import 'package:alchemy_tcg/domain/interfaces/card_zoom_handler.dart';
import 'package:alchemy_tcg/presentation/features/zoom/widgets/card_zoom.dart';
import 'package:flutter/material.dart';

class DefaultCardZoomHandler implements CardZoomHandler {
  @override
  void showCardZoom(BuildContext context, String cardPath) {
    showDialog(
      context: context,
      builder: (context) => CardZoom(cardPath: cardPath),
    );
  }
}