import 'package:flutter/material.dart';
import 'package:pushellp/models/User.dart';

class ManagePostPage extends StatelessWidget {
  static const routeName = "/managePost";
  
  final User user;
  const ManagePostPage({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Posts"),
      ),
      body: SafeArea(
        child: Center(
          child: Text(user.pseudo)
        ),
      ),
    );
  }
}