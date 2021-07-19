import 'package:flutter/material.dart';
import 'package:pushellp/commun/appBarCustom.dart';
import 'package:pushellp/commun/back_btn_custom.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/commun/header_table.dart';
import 'package:pushellp/models/User.dart';
import 'package:pushellp/screens/section/create_update_section.dart';
//import 'package:pushellp/services/http_service.dart';

class ManageSectionPage extends StatefulWidget {
  static const routeName = "/manageSections";

  final User user;
  const ManageSectionPage({Key? key, required this.user}) : super(key: key);

  @override
  _ManageSectionPageState createState() => _ManageSectionPageState();
}

class _ManageSectionPageState extends State<ManageSectionPage> {
  final Color headerColor = Colors.white;
  final double headerFontSize = 18;
  //final HttpService _httpService = HttpService();
  List<TableRow> _tableRows = [];

  @override
  Widget build(BuildContext context) {
    createTable();
    return Scaffold(
      appBar: AppBarCustom(
        title: "Manage Sections",
        userPseudo: widget.user.pseudo,
      ),
      drawer: DrawerCustom(
        user: widget.user,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BackButtonCustom(user: widget.user, btnLeadsToHomePage: true,),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("List of Sections",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateUpdateSection(user: widget.user, isCreatePage: true,),
                              ),
                            );
                          },
                          child: Text("add section"),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border: TableBorder.all(),
                      children: _tableRows,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createTable() {
    List<TableRow> tableRows = [];
    tableRows.add(TableRow(children: [
      HeaderTable(
          headerValue: "Title",
          headerColor: headerColor,
          headerFontSize: headerFontSize),
      HeaderTable(
          headerValue: "Image",
          headerColor: headerColor,
          headerFontSize: headerFontSize),
      HeaderTable(
        headerValue: "Actions",
        headerColor: headerColor,
        headerFontSize: headerFontSize,
      ),
    ]));
    _tableRows = tableRows;
  }
}
