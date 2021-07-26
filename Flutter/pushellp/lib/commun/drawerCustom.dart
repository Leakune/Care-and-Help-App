import 'package:flutter/material.dart';
import 'package:pushellp/models/User.dart';
import 'package:pushellp/screens/app_theme/manage_app_theme.dart';
import 'package:pushellp/screens/home/home_page.dart';
import 'package:pushellp/screens/notified_post/manage_notified_post.dart';
import 'package:pushellp/screens/post/manage_post.dart';
import 'package:pushellp/screens/section/manage_sections.dart';
import 'package:pushellp/screens/ticket/create_ticket.dart';
import 'package:pushellp/screens/user/manage_user.dart';

class DrawerCustom extends StatelessWidget {
  final User user;
  const DrawerCustom({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              "Pushellp",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home Page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                HomePage.routeName,
                arguments: user,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Manage Users'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                ManageUserPage.routeName,
                arguments: user,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.auto_awesome_mosaic),
            title: Text('Manage Sections'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                ManageSectionPage.routeName,
                arguments: user,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Manage Posts'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                ManagePostPage.routeName,
                arguments: user,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.report_problem),
            title: Text('Create Tickets'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                CreateTicketPage.routeName,
                arguments: user,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.brush),
            title: Text('Manage Applications Themes'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                ManageAppThemePage.routeName,
                arguments: user,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.notification_important),
            title: Text('Manage Notified Posts'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                ManageNotifiedPostPage.routeName,
                arguments: user,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
          ),
        ],
      ),
    );
  }
}
