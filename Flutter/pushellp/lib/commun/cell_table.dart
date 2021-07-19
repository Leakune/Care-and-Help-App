import 'package:flutter/material.dart';

class CellTable extends StatelessWidget {
  final String valueCell;
  final double paddingLeft;
  const CellTable(
      {Key? key, required this.valueCell, required this.paddingLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft),
      child: Text(
        valueCell,
      ),
    );
  }
}
