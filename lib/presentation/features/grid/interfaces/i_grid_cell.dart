import 'package:flutter/material.dart';

abstract class IGridCell {
  Widget buildCell(double cellSize, int row, int col);
}
