import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pushellp/models/User.dart';
import 'package:pushellp/screens/home/home_page.dart';
import 'package:pushellp/services/http_service.dart';

import 'textformfield.dart';

class Connection extends StatefulWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  _ConnectionState createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final HttpService _httpService = HttpService();
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connection"),
      ),
      body: SafeArea(
        child: Center(
          child: _futureUser == null ? buildFormLogin() : buildFutureBuilderLogin(),
        ),
      ),
    );
  }

  Form buildFormLogin() {
    return Form(
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
                isPassword: false,
              ),
            ),
            SizedBox(height: 10), // to add separation between two widgets
            Container(
              child: CustomTextFormField(
                controller: _passwordController,
                input: "Password",
                isPassword: true,
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
    );
  }

  FutureBuilder<User> buildFutureBuilderLogin() {
    return FutureBuilder<User>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Navigator.pushNamed(
            context,
            HomePage.routeName,
            arguments: snapshot.data,
          );
          return Text(snapshot.data!.pseudo);
        } else if (snapshot.hasError) {
          print(snapshot.error);
          // WidgetsBinding.instance!.addPostFrameCallback((_) =>
          //   displayAlertDialog(context, "Error", snapshot.error.toString())
          // );
          return buildFormLogin();
          //return SizedBox.shrink();

          //displayAlertDialog(snapshot.error.toString());

        }

        return CircularProgressIndicator();
      },
    );
  }

  void onClickSubmitButton() async {
    //verify if form is valid
    if (_formKey.currentState!.validate()) {
      /* TODO display AlertDialog
      setState(() {
        _futureUser = _httpService.login(
            _loginController.text.trim(), _passwordController.text.trim());
      });*/

      User user = await _httpService.login(
          _loginController.text.trim(), _passwordController.text.trim());
      Navigator.pushNamed(
        context,
        HomePage.routeName,
        arguments: user,
      );
    }
  }

  void displayAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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
