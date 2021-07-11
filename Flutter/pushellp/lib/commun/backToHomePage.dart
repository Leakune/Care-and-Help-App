import 'package:flutter/material.dart';
import 'package:pushellp/models/User.dart';
import 'package:pushellp/screens/home/home_page.dart';

class BackToHomePageButton extends StatelessWidget {
  final User user;
  const BackToHomePageButton({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 170,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(
          context,
          HomePage.routeName,
          arguments: user,
        ),
        child: Row(
          children: [
            Icon(Icons.arrow_back),
            Text("Back to Home Page"),
          ],
        ),
      ),
    );
  }
}
