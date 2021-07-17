import 'package:flutter/material.dart';

class TabBarViewCustom extends StatelessWidget {
  final double padding;
  final String title;
  final double fontSizeTitle;
  final List<TableRow> tableRows;
  const TabBarViewCustom(
      {Key? key,
      required this.padding,
      required this.title,
      required this.fontSizeTitle,
      required this.tableRows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: fontSizeTitle)),
            SizedBox(height: 15),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(),
              children: tableRows,
            )
          ],
        ),
      ),
    );
  }
}
