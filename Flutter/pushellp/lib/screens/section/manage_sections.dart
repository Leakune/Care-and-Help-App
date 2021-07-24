import 'package:flutter/material.dart';
import 'package:pushellp/commun/action_btn.dart';
import 'package:pushellp/commun/appBarCustom.dart';
import 'package:pushellp/commun/back_btn_custom.dart';
import 'package:pushellp/commun/cell_table.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/commun/header_table.dart';
import 'package:pushellp/commun/utils.dart';
import 'package:pushellp/models/Section.dart';
import 'package:pushellp/models/User.dart';
import 'package:pushellp/screens/section/create_update_section.dart';
import 'package:pushellp/services/http_service.dart';

class ManageSectionPage extends StatefulWidget {
  static const routeName = "/manageSections";

  final User user;
  const ManageSectionPage({Key? key, required this.user}) : super(key: key);

  @override
  _ManageSectionPageState createState() => _ManageSectionPageState();
}

class _ManageSectionPageState extends State<ManageSectionPage> {
  final baseUrlSrcIcon = "http://0.0.0.0:3000/uploads/sections/";
  final double paddingLeftCellTable = 5.0;
  final Color headerColor = Colors.white;
  final double headerFontSize = 18;
  final HttpService _httpService = HttpService();

  @override
  Widget build(BuildContext context) {
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
                child: BackButtonCustom(
                  user: widget.user,
                  btnLeadsToHomePage: true,
                ),
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
                                builder: (context) => CreateUpdateSection(
                                  user: widget.user,
                                  isCreatePage: true,
                                ),
                              ),
                            );
                          },
                          child: Text("add section"),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    FutureBuilder(
                      future: _httpService.getSections(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            if (!snapshot.hasData) {
                              return Text("Sections not found");
                            }
                            List<Section> sections =
                                snapshot.data! as List<Section>;
                            return createTable(sections);
                          default:
                            return Text("Section");
                        }
                      },
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

  Table createTable(List<Section> sections) {
    List<TableRow> tableRows = [];
    tableRows.add(TableRow(children: [
      HeaderTable(
          headerValue: "Title",
          headerColor: headerColor,
          headerFontSize: headerFontSize),
      HeaderTable(
          headerValue: "Description",
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
    for (var s in sections) {
      var title = s.title;
      var srcIcon = s.srcicon != "" ? s.srcicon! : "null";
      var image = getImage(srcIcon);
      
      tableRows.add(TableRow(children: [
        CellTable(valueCell: s.title, paddingLeft: paddingLeftCellTable),
         CellTable(valueCell: s.description, paddingLeft: paddingLeftCellTable),
         Container(
           child: image,
         ),
        Row(
          children: [
            ActionBtn(
              icon: Icon(Icons.edit),
              isLeadingToUpdateSection: true,
              user: widget.user,
              section: s,
            ),
            ActionBtn(
              title: "Delete section",
              question: "Are you sure you want to delete the section $title?",
              callback: () async {
                try {
                  await _httpService.deleteSectionById(s.idSection);
                  Navigator.of(context).pop();
                  setState(() {});
                } catch (err) {
                  print("Error: $err");
                  Utils.displayAlertDialog(
                      context, "Error deleting the user", err.toString());
                }
              },
              icon: Icon(Icons.delete),
              isLeadingToUpdateSection: false,
            )
          ],
        )
      ]));
    }
    return Table(//IntrinsicColumnWidth
      columnWidths: {
                2: IntrinsicColumnWidth(),
              },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(),
      children: tableRows,
    );
  }
  dynamic getImage(String srcIcon){
    var image;
    try{
      image = Padding(
          padding: EdgeInsets.only(left: paddingLeftCellTable),
          child: Image.network(baseUrlSrcIcon + srcIcon,scale: 1.5, fit: BoxFit.fitWidth,),
      );
    }catch(err){
      image = SizedBox();
    }
    return image;
  }
}
