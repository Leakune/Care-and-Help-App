import 'package:flutter/material.dart';
import 'package:pushellp/models/User.dart';
import 'package:pushellp/screens/home/home_page.dart';

class BackButtonCustom extends StatelessWidget {
  final User? user;
  final bool btnLeadsToHomePage;
  const BackButtonCustom({Key? key, this.user, required this.btnLeadsToHomePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: btnLeadsToHomePage ? 170 : 80,
      child: ElevatedButton(
        onPressed: () => onPressed(context),
        child: Row(
          children: [
            Icon(Icons.arrow_back),
            Text(btnLeadsToHomePage ? "Back to Home Page" : "Back"),
          ],
        ),
      ),
    );
  }
  void onPressed(BuildContext context){
    if(btnLeadsToHomePage){
      Navigator.pushNamed(
          context,
          HomePage.routeName,
          arguments: user,
      );
    }else{
      Navigator.pop(context);
    }
  }
}
