import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pushellp/models/Section.dart';
import 'package:pushellp/models/User.dart';

class HttpService {
  final _baseUrl = "http://0.0.0.0:3000/";

  Future<User> login(String username, String password) async {
    try{
      final response = await http.post(
        Uri.parse(_baseUrl + "login"),
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
    }catch(err){
      throw Exception(err);
    } 
  }

  Future<List<User>> getUsersByStatus(String status) async {
    try{
      final response = await http.get(
        Uri.parse(_baseUrl + "getIndividualsByStatus?status=" + status),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        dynamic jsonError = json["error"];
        throw Exception(jsonError);
      }
      List<dynamic> jsonArrayUser = json["body"]["data"];
      List<User> users =
          jsonArrayUser.map((dynamic it) => User.fromJson(it)).toList();
      return users;
    }catch(err){
      throw Exception(err);
    } 
  }

  Future<void> setUserStatusAdminByIdUser(int idUserToPromote, int idUserWhoPromotes) async{
    try{
      final response = await http.put(
        Uri.parse(_baseUrl + "setUserStatusAdminByIdUser"),
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
        dynamic jsonError = json["error"];
        throw Exception(jsonError);
      }
    }catch(err){
      throw Exception(err);
    } 
  }

  Future<void> deleteUserById(int idUser) async{
    try{
      final response = await http.delete(
        Uri.parse(_baseUrl + "deleteUserById"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'idUser': idUser,
        }),
      );
      var json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        dynamic jsonError = json["error"];
        throw Exception(jsonError);
      }
    }catch(err){
      throw Exception(err);
    }  
  }
  Future<void> createSection(String title, String description) async {
    try{
      final response = await http.post(
        Uri.parse(_baseUrl + "createSection"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'description': description,
        }),
      );
      var json = jsonDecode(response.body);

      if (response.statusCode != 200) {
        String jsonError = json["error"];
        throw Exception(jsonError);
      }
    }catch(err){
      throw Exception(err);
    } 
  }
  Future<List<Section>> getSections() async{
    try{
      final response = await http.get(
        Uri.parse(_baseUrl + "getSections"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        dynamic jsonError = json["error"];
        throw Exception(jsonError);
      }
      List<dynamic> jsonArraySection= json["body"]["data"];
      List<Section> sections =
          jsonArraySection.map((dynamic it) => Section.fromJson(it)).toList();
      return sections;
    }catch(err){
      throw Exception(err);
    } 
  }
  Future<void> setSectionById(int idSection, String title, String description) async{
    try{
      final response = await http.put(
        Uri.parse(_baseUrl + "setSectionById"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'idSection': idSection,
          'title': title,
          'description': description
        }),
      );
      var json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        dynamic jsonError = json["error"];
        throw Exception(jsonError);
      }
    }catch(err){
      throw Exception(err);
    } 
  }
  Future<void> deleteSectionById(int idSection) async{
    try{
      final response = await http.delete(
        Uri.parse(_baseUrl + "deleteSectionById"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'idSection': idSection,
        }),
      );
      var json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        dynamic jsonError = json["error"];
        throw Exception(jsonError);
      }
    }catch(err){
      throw Exception(err);
    }  
  }
}
