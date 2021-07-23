import 'package:flutter/material.dart';
import 'package:pushellp/commun/utils.dart';
import 'package:pushellp/models/Section.dart';
import 'package:pushellp/models/User.dart';
import 'package:pushellp/screens/section/create_update_section.dart';

class ActionBtn extends StatelessWidget {
  final String? title;
  final String? question;
  final VoidCallback? callback;
  final dynamic icon;
  final bool isLeadingToUpdateSection;
  final User? user;
  final Section? section;

  const ActionBtn(
      {Key? key,
      this.title,
      this.question,
      this.callback,
      required this.icon,
      required this.isLeadingToUpdateSection,
      this.user,
      this.section})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isLeadingToUpdateSection) {
          goToUpdateManageSection(context);
        } else {
          displayDialog(context);
        }
      },
      child: icon,
    );
  }

  void goToUpdateManageSection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateUpdateSection(
          user: user!,
          section: section,
          isCreatePage: false,
        ),
      ),
    );
  }

  void displayDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget confirmButton = TextButton(
      child: Text("Yes"),
      onPressed: callback,
    );
    Utils.displayAlertDialogChoices(
        context: context,
        title: title!,
        question: question!,
        cancelBtn: cancelButton,
        confirmBtn: confirmButton);
  }
}
