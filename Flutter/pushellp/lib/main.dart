import 'package:flutter/material.dart';
import 'package:pushellp/screens/home/home_page.dart';

import 'models/User.dart';
import 'screens/connection/connection.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pushellp",
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onGenerateRoute: (settings){
        if(settings.name == HomePage.routeName){
          final args = settings.arguments as User;
          return MaterialPageRoute(builder: (context){
            return HomePage(user: args);
          });
        }
      },
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connection"),
      ),
      body: SafeArea(
        child: Connection(),
      ),
    );
  }
}
