import 'package:flutter/material.dart';

abstract class CellBehavior {
  Widget build(BuildContext context, {
    required double cellSize,
    required int row,
    required int col,
  });
} 