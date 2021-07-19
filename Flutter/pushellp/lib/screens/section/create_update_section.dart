import 'package:flutter/material.dart';
import 'package:pushellp/commun/appBarCustom.dart';
import 'package:pushellp/commun/back_btn_custom.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/models/User.dart';

class CreateUpdateSection extends StatelessWidget {
  final User user;
  final bool isCreatePage;
  const CreateUpdateSection({Key? key, required this.user, required this.isCreatePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: "Manage Sections",
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
                child: BackButtonCustom(
                  user: user,
                  btnLeadsToHomePage: false,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      isCreatePage ? "Create a section" : "Update a section",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
