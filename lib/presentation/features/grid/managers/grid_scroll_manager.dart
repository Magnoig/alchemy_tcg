import 'package:flutter/widgets.dart';
import 'package:alchemy_tcg/core/constants/game_constants.dart';


class GridScrollManager {
  final ScrollController controller = ScrollController();
  
  void initializeScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: GameConstants.scrollDuration,
        curve: Curves.easeOut,
      );
    });
  }
  
  void dispose() {
    controller.dispose();
  }
}