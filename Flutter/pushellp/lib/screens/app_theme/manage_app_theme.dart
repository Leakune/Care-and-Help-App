import 'package:flutter/material.dart';
import 'package:pushellp/commun/back_btn_custom.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/models/User.dart';

class ManageAppThemePage extends StatelessWidget {
  static const routeName = "/manageAppTheme";
  
  final User user;
  const ManageAppThemePage({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Themes"),
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
                child: BackButtonCustom(user: user, btnLeadsToHomePage: true,),
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