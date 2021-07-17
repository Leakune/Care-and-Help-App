import 'package:flutter/material.dart';
import 'package:pushellp/commun/utils.dart';

class ActionBtn extends StatelessWidget {
  final String title;
  final String question;
  final VoidCallback callback;
  final dynamic icon;
  const ActionBtn(
      {Key? key,
      required this.title,
      required this.question,
      required this.callback, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
            title: title,
            question: question,
            cancelBtn: cancelButton,
            confirmBtn: confirmButton);
      },
      child: icon,
    );
  }
}
