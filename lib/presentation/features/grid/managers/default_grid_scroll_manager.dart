import 'package:alchemy_tcg/core/constants/game_constants.dart';
import 'package:alchemy_tcg/presentation/features/grid/managers/grid_scroll_manager.dart';
import 'package:flutter/widgets.dart';

class DefaultGridScrollManager implements GridScrollManager {
  @override
  final ScrollController controller = ScrollController();
  
  @override
  void initializeScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: GameConstants.scrollDuration,
        curve: Curves.easeOut,
      );
    });
  }
  
  @override
  void dispose() {
    controller.dispose();
  }
}