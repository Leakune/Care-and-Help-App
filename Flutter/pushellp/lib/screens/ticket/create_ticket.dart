import 'package:flutter/material.dart';
import 'package:pushellp/models/User.dart';

class CreateTicketPage extends StatelessWidget {
  static const routeName = "/createTicket";

  final User user;
  const CreateTicketPage({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Tickets"),
      ),
      body: SafeArea(
        child: Center(
          child: Text(user.pseudo)
        ),
      ),
    );
  }
}