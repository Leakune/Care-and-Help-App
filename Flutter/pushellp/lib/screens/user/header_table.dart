import 'package:flutter/material.dart';

class HeaderTable extends StatelessWidget {
  final String headerValue;
  final Color headerColor;
  final double headerFontSize;
  const HeaderTable(
      {Key? key,
      required this.headerValue,
      required this.headerColor,
      required this.headerFontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          headerValue,
          style: TextStyle(
              color: headerColor,
              fontWeight: FontWeight.bold,
              fontSize: headerFontSize),
        ),
      ),
    );
  }
}
