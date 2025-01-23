import 'package:flutter/material.dart';
import '../constants/game_constants.dart';

class CardZoom extends StatelessWidget {
  final String cardPath;

  const CardZoom({Key? key, required this.cardPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: MediaQuery.of(context).size.width * GameConstants.zoomWidthFactor,
          height: MediaQuery.of(context).size.height * GameConstants.zoomHeightFactor,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(cardPath),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
} 