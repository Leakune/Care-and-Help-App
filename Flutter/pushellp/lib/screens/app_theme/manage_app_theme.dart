import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: Center(
          child: Text(user.pseudo)
        ),
      ),
    );
  }
}