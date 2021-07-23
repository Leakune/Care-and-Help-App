import 'package:flutter/material.dart';
import 'package:pushellp/commun/utils.dart';

class AbandonBtn extends StatelessWidget {
  final String title;
  final String question;
  final BuildContext contextParent;
  final dynamic icon;
  const AbandonBtn(
      {Key? key,
      required this.title,
      required this.question,
      this.icon,
      required this.contextParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // set up the buttons
        Widget cancelButton = TextButton(
          child: Text("No"),
          onPressed: () => Navigator.of(context).pop(),
        );
        Widget confirmButton = TextButton(
          child: Text("Yes"),
          onPressed: (){
            Navigator.of(context).pop();
            Navigator.of(contextParent).pop();
          },
        );
        Utils.displayAlertDialogChoices(
            context: context,
            title: title,
            question: question,
            cancelBtn: cancelButton,
            confirmBtn: confirmButton);
      },
      child: Text("Abandon"),
    );
  }
}
