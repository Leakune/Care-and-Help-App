// import 'package:flutter/material.dart';
// import 'package:pushellp/models/User.dart';
// import 'package:pushellp/screens/app_theme/manage_app_theme.dart';
// import 'package:pushellp/screens/home/home_page.dart';
// import 'package:pushellp/screens/notified_post/manage_notified_post.dart';
// import 'package:pushellp/screens/post/manage_post.dart';
// import 'package:pushellp/screens/section/manage_sections.dart';
// import 'package:pushellp/screens/ticket/create_ticket.dart';
// import 'package:pushellp/screens/user/manage_user.dart';

// class MyRouter{
//   static Route<dynamic>? generateRoute(RouteSettings settings){
//     //Home Page
//     if(settings.name == HomePage.routeName){
//       final args = settings.arguments as User;
//       return MaterialPageRoute(builder: (context){
//         return HomePage(user: args);
//       });
//     }
//       //Manage Users
//     if(settings.name == ManageUserPage.routeName){
//       final args = settings.arguments as User;
//       return MaterialPageRoute(builder: (context){
//         return ManageUserPage(user: args);
//       });
//     }
//     //Create Tickets
//     if(settings.name == CreateTicketPage.routeName){
//       final args = settings.arguments as User;
//       return MaterialPageRoute(builder: (context){
//         return CreateTicketPage(user: args);
//       });
//     }
//     //Manage Sections
//     if(settings.name == ManageSectionPage.routeName){
//       final args = settings.arguments as User;
//       return MaterialPageRoute(builder: (context){
//         return ManageSectionPage(user: args);
//       });
//     }
//     //Manage Posts
//     if(settings.name == ManagePostPage.routeName){
//       final args = settings.arguments as User;
//       return MaterialPageRoute(builder: (context){
//         return ManagePostPage(user: args);
//       });
//     }
//     //Manage Notified Posts
//     if(settings.name == ManageNotifiedPostPage.routeName){
//       final args = settings.arguments as User;
//       return MaterialPageRoute(builder: (context){
//         return ManageNotifiedPostPage(user: args);
//       });
//     }
//     //Manage App Theme
//     if(settings.name == ManageAppThemePage.routeName){
//       final args = settings.arguments as User;
//       return MaterialPageRoute(builder: (context){
//         return ManageAppThemePage(user: args);
//       });
//     }
//     //page not found
//     return MaterialPageRoute(builder: (context){ 
//       return Center(child: Text("Error: Page not found"));
//     });
//   }
// }