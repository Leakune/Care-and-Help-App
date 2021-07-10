import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pushellp/models/User.dart';

class HttpService {
  final urlLogin = "http://0.0.0.0:3000/login";

  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(urlLogin),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    var json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      String jsonError = json["error"];
      throw Exception(jsonError);
    }
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    var jsonUser = json["body"]["data"][0];
    return User.fromJson(jsonUser);
  }
}