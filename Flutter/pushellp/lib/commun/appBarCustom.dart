import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String userPseudo;
  const AppBarCustom({Key? key, required this.title, required this.userPseudo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Row(
          children: [
            Image.asset('assets/images/unknown_profile.png'),
            Padding(
              padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(width: 30),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Text(
                            userPseudo,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false), //back to root navigation = connection
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
