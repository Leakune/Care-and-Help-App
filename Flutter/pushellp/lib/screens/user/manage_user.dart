import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pushellp/commun/appBarCustom.dart';
import 'package:pushellp/commun/backToHomePage.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/models/User.dart';
import 'package:pushellp/screens/user/action_btn.dart';
import 'package:pushellp/screens/user/cell_table.dart';
import 'package:pushellp/screens/user/header_table.dart';
import 'package:pushellp/screens/user/tab_bar_view_custom.dart';
import 'package:pushellp/services/http_service.dart';

class ManageUserPage extends StatefulWidget {
  static const routeName = "/manageUser";

  final User user;
  const ManageUserPage({Key? key, required this.user}) : super(key: key);

  @override
  _ManageUserPageState createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage>
    with SingleTickerProviderStateMixin {
  final double paddingLeftCellTable = 5.0;
  final Color headerColor = Colors.white;
  final double headerFontSize = 18;
  final double tabBarViewPadding = 20;
  final double fontSizeTitle = 24;
  final HttpService _httpService = HttpService();
  TabController? _tabController;
  int _selectedIndex = 0;
  List<TableRow> _tableRows = [];

  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController!.addListener(() {
      setState(() {
        _selectedIndex = _tabController!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    createTable();

    return Scaffold(
      appBar: AppBarCustom(
        title: "Manage Users",
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
                child: BackToHomePageButton(user: widget.user),
              ),
            ),
            SizedBox(height: 10),
            Material(
              color: Colors.blue,
              child: TabBar(
                // unselectedLabelColor: Colors.black,
                // labelColor: Colors.red,
                tabs: [
                  Tab(
                    text: "Android",
                  ),
                  Tab(
                    text: "Ios",
                  ),
                  Tab(
                    text: "Flutter",
                  )
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TabBarViewCustom(
                      padding: tabBarViewPadding,
                      title: "List of visitors",
                      fontSizeTitle: fontSizeTitle,
                      tableRows: _tableRows),
                  TabBarViewCustom(
                      padding: tabBarViewPadding,
                      title: "List of admins",
                      fontSizeTitle: fontSizeTitle,
                      tableRows: _tableRows),
                  TabBarViewCustom(
                      padding: tabBarViewPadding,
                      title: "List of super admins",
                      fontSizeTitle: fontSizeTitle,
                      tableRows: _tableRows),
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createTable() async {
    String status = "client";
    switch (_selectedIndex) {
      case 0:
        status = "client";
        break;
      case 1:
        status = "admin";
        break;
      case 2:
        status = "superadmin";
        break;
    }
    List<User> users = await _httpService.getUsersByStatus(status);
    List<TableRow> tableRows = [];
    tableRows.add(TableRow(children: [
      HeaderTable(
          headerValue: "Pseudo",
          headerColor: headerColor,
          headerFontSize: headerFontSize),
      HeaderTable(
          headerValue: "Email",
          headerColor: headerColor,
          headerFontSize: headerFontSize),
      HeaderTable(
          headerValue: "Register date",
          headerColor: headerColor,
          headerFontSize: headerFontSize),
      HeaderTable(
          headerValue: "Birthday",
          headerColor: headerColor,
          headerFontSize: headerFontSize),
      HeaderTable(
          headerValue: "Actions",
          headerColor: headerColor,
          headerFontSize: headerFontSize),
    ]));
    for (var u in users) {
      var pseudo = u.pseudo;
      var email = u.email;
      var promoteUserActionBtn = status == "client"
          ? ActionBtn(
              title: "Delete user",
              question:
                  "Are you sure you want to promote the user $pseudo into an admin?",
              callback: () async {
                await _httpService.setUserStatusAdminByIdUser(u.idUser, widget.user.idUser);
                Navigator.of(context).pop();
                setState(() {}); //TODO update list of users after the change of the status
                // setState(() {
                //   _selectedIndex = _tabController!.index;
                // });
              },
              icon: ImageIcon(AssetImage('images/promote.png')),
            )
          : SizedBox();
      tableRows.add(TableRow(children: [
        CellTable(valueCell: pseudo, paddingLeft: paddingLeftCellTable),
        CellTable(valueCell: email, paddingLeft: paddingLeftCellTable),
        CellTable(
            valueCell: formatDate(u.registerdate.toString()),
            paddingLeft: paddingLeftCellTable),
        CellTable(
            valueCell: formatDate(u.birthday.toString()),
            paddingLeft: paddingLeftCellTable),
        Row(
          children: [
            promoteUserActionBtn,
            ActionBtn(
              title: "Delete user",
              question: "Are you sure you want to delete the user $pseudo?",
              callback: () {
                print("delete clicked");
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ]));
    }
    _tableRows = tableRows;
  }
}

String formatDate(String date) {
  var inputFormat = DateFormat("yyyy-MM-dd' HH:mm:ss");
  var inputDate = inputFormat.parse(date);

  var outputFormat = DateFormat("dd/MM/yyyy");
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}
