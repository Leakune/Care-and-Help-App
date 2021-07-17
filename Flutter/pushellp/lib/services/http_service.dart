import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pushellp/models/User.dart';

class HttpService {
  final baseUrl = "http://0.0.0.0:3000/";

  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl + "login"),
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

  Future<List<User>> getUsersByStatus(String status) async {
    final response = await http.get(
      Uri.parse(baseUrl + "getIndividualsByStatus?status=" + status),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      String jsonError = json["error"];
      throw Exception(jsonError);
    }
    List<dynamic> jsonArrayUser = json["body"]["data"];
    List<User> users =
        jsonArrayUser.map((dynamic it) => User.fromJson(it)).toList();
    return users;
  }
  Future<void> setUserStatusAdminByIdUser(int idUserToPromote, int idUserWhoPromotes) async{
    final response = await http.put(
      Uri.parse(baseUrl + "setUserStatusAdminByIdUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'idUserToPromote': idUserToPromote,
        'idUserWhoPromotes': idUserWhoPromotes,
      }),
    );
    var json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      String jsonError = json["error"];
      throw Exception(jsonError);
    }
  }
}
