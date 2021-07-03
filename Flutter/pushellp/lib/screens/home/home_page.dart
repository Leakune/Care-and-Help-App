import 'package:flutter/material.dart';
import 'package:pushellp/models/User.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/homePage";

  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Text(user.pseudo),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Go back!'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
