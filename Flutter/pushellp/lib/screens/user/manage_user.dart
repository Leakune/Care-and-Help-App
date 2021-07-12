import 'package:flutter/material.dart';
import 'package:pushellp/commun/appBarCustom.dart';
import 'package:pushellp/commun/backToHomePage.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/models/User.dart';

class ManageUserPage extends StatefulWidget {
  static const routeName = "/manageUser";
  final User user;
  const ManageUserPage({Key? key, required this.user}) : super(key: key);

  @override
  _ManageUserPageState createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> with SingleTickerProviderStateMixin{
  late TabController _tabController = new TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
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
                  Center(child: Text("List of visitors")),
                  Center(child: Text("List of admins")),
                  Center(child: Text("List of super-admins"))
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
