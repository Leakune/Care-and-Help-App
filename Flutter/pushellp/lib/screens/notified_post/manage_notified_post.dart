import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: Center(
          child: Text(user.pseudo)
        ),
      ),
    );
  }
}