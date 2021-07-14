import 'package:flutter/material.dart';
import 'package:pushellp/commun/appBarCustom.dart';
import 'package:pushellp/commun/backToHomePage.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/models/User.dart';
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
      print("Selected Index: " + _tabController!.index.toString());
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("List of visitors", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                          SizedBox(height: 15),
                          Table(
                            border: TableBorder.all(),
                            children: _tableRows,
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("List of admins", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                          SizedBox(height: 15),
                          Table(
                            border: TableBorder.all(),
                            columnWidths: {
                              3: FlexColumnWidth(1)
                            },
                            children: _tableRows,
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("List of super admins", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                          SizedBox(height: 15),
                          Table(
                            border: TableBorder.all(),
                            children: _tableRows,
                          )
                        ],
                      ),
                    ),
                  )
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
        print("creating table android");
        status = "client";
        break;
      case 1:
        print("creating table ios");
        status = "admin";
        break;
      case 2:
        print("creating table flutter");
        status = "superadmin";
        break;
    }
    List<User> users = await _httpService.getUsersByStatus(status);
    List<TableRow> tableRows = [];
    tableRows.add(TableRow(children: [
      Text(
        "Pseudo",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      Text(
        "Email",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      Text(
        "Register date",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      Text(
        "birthday",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      Text(
        "Actions",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      )
    ]));
    for (var user in users) {
      tableRows.add(TableRow(children: [
        Text(
          user.pseudo,
        ),
        Text(
          user.email,
        ),
        Text(
          user.registerdate.toString(),
        ),
        Text(
          user.birthday.toString(),
        ),
        Row(children: [ImageIcon(AssetImage('images/promote.png')),Icon(Icons.delete)],),
      ]));
    }
    _tableRows = tableRows;
    //return Table(border: TableBorder.all(), children: tableRows,)
  }
}

