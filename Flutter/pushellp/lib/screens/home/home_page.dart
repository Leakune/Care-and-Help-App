import 'package:flutter/material.dart';
import 'package:pushellp/models/User.dart';
import 'package:pushellp/screens/app_theme/manage_app_theme.dart';
import 'package:pushellp/screens/home/custom_button.dart';
import 'package:pushellp/screens/notified_post/manage_notified_post.dart';
import 'package:pushellp/screens/post/manage_post.dart';
import 'package:pushellp/screens/section/manage_sections.dart';
import 'package:pushellp/screens/ticket/create_ticket.dart';
import 'package:pushellp/screens/user/manage_user.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/homePage";

  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Home page");
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 4;
    final double itemWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(60, 100, 60, 0),
            child: Container(
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: (itemWidth / itemHeight),
                mainAxisSpacing: 100,
                crossAxisSpacing: 30,
                children: [
                  Container(
                    child: CustomElevatedButton(
                      text: "Manage Users",
                      callback: () {
                        Navigator.pushNamed(
                          context,
                          ManageUserPage.routeName,
                          arguments: user,
                        );
                      },
                    ),
                  ),
                  Container(
                    child: CustomElevatedButton(
                      text: "Manage Sections",
                      callback: () {
                        Navigator.pushNamed(
                          context,
                          ManageSectionPage.routeName,
                          arguments: user,
                        );
                      },
                    ),
                  ),
                  Container(
                    child: CustomElevatedButton(
                      text: "Manage Posts",
                      callback: () {
                        Navigator.pushNamed(
                          context,
                          ManagePostPage.routeName,
                          arguments: user,
                        );
                      },
                    ),
                  ),
                  Container(
                    child: CustomElevatedButton(
                      text: "Create Tickets",
                      callback: () {
                        Navigator.pushNamed(
                          context,
                          CreateTicketPage.routeName,
                          arguments: user,
                        );
                      },
                    ),
                  ),
                  Container(
                    child: CustomElevatedButton(
                      text: "Manage Applications Themes",
                      callback: () {
                        Navigator.pushNamed(
                          context,
                          ManageAppThemePage.routeName,
                          arguments: user,
                        );
                      },
                    ),
                  ),
                  Container(
                    child: CustomElevatedButton(
                      text: "Manage Notified Posts",
                      callback: () {
                        Navigator.pushNamed(
                          context,
                          ManageNotifiedPostPage.routeName,
                          arguments: user,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
