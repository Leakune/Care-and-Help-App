import 'package:flutter/material.dart';
import 'package:pushellp/router/router.dart';
import 'package:pushellp/screens/home/home_page.dart';

import 'models/User.dart';
import 'screens/app_theme/manage_app_theme.dart';
import 'screens/connection/connection.dart';
import 'screens/notified_post/manage_notified_post.dart';
import 'screens/post/manage_post.dart';
import 'screens/section/manage_sections.dart';
import 'screens/ticket/create_ticket.dart';
import 'screens/user/manage_user.dart';

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
        //MyRouter.generateRoute(settings);
        //Home Page
        if(settings.name == HomePage.routeName){
          final args = settings.arguments as User;
          return MaterialPageRoute(builder: (context){
            return HomePage(user: args);
          });
        }
          //Manage Users
        if(settings.name == ManageUserPage.routeName){
          final args = settings.arguments as User;
          return MaterialPageRoute(builder: (context){
            return ManageUserPage(user: args);
          });
        }
        //Create Tickets
        if(settings.name == CreateTicketPage.routeName){
          final args = settings.arguments as User;
          return MaterialPageRoute(builder: (context){
            return CreateTicketPage(user: args);
          });
        }
        //Manage Sections
        if(settings.name == ManageSectionPage.routeName){
          final args = settings.arguments as User;
          return MaterialPageRoute(builder: (context){
            return ManageSectionPage(user: args);
          });
        }
        //Manage Posts
        if(settings.name == ManagePostPage.routeName){
          final args = settings.arguments as User;
          return MaterialPageRoute(builder: (context){
            return ManagePostPage(user: args);
          });
        }
        //Manage Notified Posts
        if(settings.name == ManageNotifiedPostPage.routeName){
          final args = settings.arguments as User;
          return MaterialPageRoute(builder: (context){
            return ManageNotifiedPostPage(user: args);
          });
        }
        //Manage App Theme
        if(settings.name == ManageAppThemePage.routeName){
          final args = settings.arguments as User;
          return MaterialPageRoute(builder: (context){
            return ManageAppThemePage(user: args);
          });
        }
        //page not found
        return MaterialPageRoute(builder: (context){ 
          return Center(child: Text("Error: Page not found"));
        });
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
    return Connection();
  }
}
