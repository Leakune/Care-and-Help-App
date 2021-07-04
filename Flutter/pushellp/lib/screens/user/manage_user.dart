import 'package:flutter/material.dart';
import 'package:pushellp/models/User.dart';

class ManageUserPage extends StatelessWidget {
  static const routeName = "/manageUser";
  
  final User user;
  const ManageUserPage({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Users"),
      ),
      body: SafeArea(
        child: Center(
          child: Text(user.pseudo)
        ),
      ),
    );
  }
}