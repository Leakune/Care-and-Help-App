import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pushellp/commun/action_btn.dart';
import 'package:pushellp/commun/appBarCustom.dart';
import 'package:pushellp/commun/back_btn_custom.dart';
import 'package:pushellp/commun/cell_table.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/commun/header_table.dart';
import 'package:pushellp/commun/utils.dart';
import 'package:pushellp/models/User.dart';
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
    // if(_loading){
    //   return CircularProgressIndicator();
    // }
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
                child: BackButtonCustom(user: widget.user, btnLeadsToHomePage: true,),
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
    try{
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
          headerFontSize: headerFontSize,
        ),
      ]));
      for (var u in users) {
        var pseudo = u.pseudo;
        var email = u.email;
        var promoteUserActionBtn;
        var deleteUserActionBtn;
        if(status == "client"){
          promoteUserActionBtn = ActionBtn(
                title: "Upgrade user",
                question:
                    "Are you sure you want to promote the user $pseudo into an admin?",
                callback: () async {
                  try{
                    await _httpService.setUserStatusAdminByIdUser(u.idUser, widget.user.idUser);
                    Navigator.of(context).pop();
                    setState(() {});
                  }catch(err){
                    print("Error: $err");
                    Utils.displayAlertDialog(context, "Error updating the user", err.toString());
                  }
                },
                icon: ImageIcon(AssetImage('images/promote.png')), isLeadingToUpdateSection: false,
              );
        }else{
          promoteUserActionBtn = SizedBox();
        }
        if(status == "superadmin"){
          deleteUserActionBtn = SizedBox();
        }else{
          deleteUserActionBtn = ActionBtn(
            title: "Delete user",
            question: "Are you sure you want to delete the user $pseudo?",
            callback: () async{
              try{
                await _httpService.deleteUserById(u.idUser);
                Navigator.of(context).pop();
                setState(() {});
              }catch(err){
                print("Error: $err");
                Utils.displayAlertDialog(context, "Error deleting the user", err.toString());
              }  
            },
            icon: Icon(Icons.delete), isLeadingToUpdateSection: false,
          );
        }
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
              deleteUserActionBtn
            ],
          ),
        ]));
      }
      _tableRows = tableRows;
    }catch(err){
      print("Error: $err");
      Utils.displayAlertDialog(context, "Error getting the user list", err.toString());
    }
  }
}

String formatDate(String date) {
  var inputFormat = DateFormat("yyyy-MM-dd' HH:mm:ss");
  var inputDate = inputFormat.parse(date);

  var outputFormat = DateFormat("dd/MM/yyyy");
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}
