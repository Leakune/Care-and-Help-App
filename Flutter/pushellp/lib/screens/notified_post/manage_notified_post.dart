import 'package:flutter/material.dart';
import 'package:pushellp/commun/backToHomePage.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/models/User.dart';

class ManageNotifiedPostPage extends StatelessWidget {
  static const routeName = "/manageNotifiedPostPage";

  final User user;
  const ManageNotifiedPostPage({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Notified Posts"),
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