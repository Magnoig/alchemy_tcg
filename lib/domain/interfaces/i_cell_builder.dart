import 'package:flutter/widgets.dart';

abstract class ICellBuilder {
  Widget buildCell(
    double cellSize,
    int row, 
    int col,  
  );
}