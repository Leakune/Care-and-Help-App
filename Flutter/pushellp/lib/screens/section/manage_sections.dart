import 'package:flutter/material.dart';
import 'package:pushellp/models/User.dart';

class ManageSectionPage extends StatelessWidget {
  static const routeName = "/manageSections";

  final User user;
  const ManageSectionPage({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Sections"),
      ),
      body: SafeArea(
        child: Center(
          child: Text(user.pseudo)
        ),
      ),
    );
  }
}