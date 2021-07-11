import 'package:flutter/material.dart';
import 'package:pushellp/commun/appBarCustom.dart';
import 'package:pushellp/commun/backToHomePage.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/models/User.dart';

class ManageUserPage extends StatelessWidget {
  static const routeName = "/manageUser";

  final User user;
  const ManageUserPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: "Manage Users",
        userPseudo: user.pseudo,
      ),
      drawer: DrawerCustom(
        user: user,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BackToHomePageButton(user: user),
              ),
            ),
            Center(
              child: Text(user.pseudo),
            ),
          ],
        ),
      ),
    );
  }
}
