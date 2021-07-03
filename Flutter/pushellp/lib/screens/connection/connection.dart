import 'package:flutter/material.dart';
import 'package:pushellp/models/User.dart';
import 'package:pushellp/screens/home/home_page.dart';

import 'textformfield.dart';

class Connection extends StatefulWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  _ConnectionState createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: CustomTextFormField(
                  controller: _loginController,
                  input: "Login",
                ),
              ),
              SizedBox(height: 10), // to add separation between two widgets
              Container(
                child: CustomTextFormField(
                  controller: _passwordController,
                  input: "Password",
                ),
              ),
              SizedBox(height: 10), // to add separation between two widgets
              ElevatedButton(
                onPressed: onClickSubmitButton,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClickSubmitButton() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));

      if (_loginController.text.trim().compareTo("Ludovic") != 0 ||
          _passwordController.text.trim().compareTo("Password") != 0) {
        displayAlertDialog("Your login and/or password are not correct.");
        return;
      }
      Navigator.pushNamed(
        context,
        HomePage.routeName,
        arguments: User(_loginController.text.trim()),
      );
    }
  }

  void displayAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
