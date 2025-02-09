import 'package:flutter/widgets.dart';

abstract class ICellBuilder {
  Widget buildCell(
    int row, 
    int col, 
    double cellSize, 
  );
}