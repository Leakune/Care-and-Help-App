import 'dart:convert';
import 'dart:html'as html;
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pushellp/models/User.dart';
import 'package:image_picker_web/image_picker_web.dart';

class UploadService{
  final _baseUrl= "http://0.0.0.0:3000/";

  Future<void> uploadFile({required List<int> selectedFile, required Uint8List? bytesData, required User user}) async {
    try{
      var url = Uri.parse(
          _baseUrl + "uploadImageSection");
      // var request = new http.MultipartRequest("POST", url);
      var dio = Dio();
      //dio.options.baseUrl = _baseUrl + "uploadImageSection";
      // dio.options.connectTimeout = 5000; //5s
      // dio.options.receiveTimeout = 5000;
      //String fileName = imageFile.name.split('/').last;

      // var request = new http.MultipartRequest("POST", url);
      // request.files.add(await http.MultipartFile.fromBytes('file', selectedFile,
      //     contentType: new MediaType('application', 'octet-stream'),
      //     filename: "lol"));
      // request.files.add(await http.MultipartFile.fromString('id', user.idUser.toString(),
      //     contentType: new MediaType('application', 'json'),
      //     ));

      // request.headers['Content-Type'] = "application/json";

      // request.send().then((response) {
      //   print(response.statusCode);
      // });
      
      var formData = FormData.fromMap({
        'idUser': user.idUser,
        'file': http.MultipartFile.fromBytes('file', selectedFile,
          contentType: new MediaType('multipart', 'form-data'), filename: "filename")
      });
      var response = await dio.post(_baseUrl + "uploadImageSection", data: formData);
      if (response.statusCode != 200) {
        throw Exception("failed to upload");
      }
    }
    catch(err){
      throw Exception(err);
    }
    // request.files.add(await http.MultipartFile.fromBytes('file', selectedFile,
    //     contentType: new MediaType('application', 'octet-stream'),
    //     filename: "file_up"));

    // request.send().then((response) {
    //   print("test");
    //   print(response.statusCode);
    //   if (response.statusCode == 200) print("Uploaded!");
    // });
  }

    //print(imageFile);
    // try{
    //   var dio = Dio();
    //   dio.options.baseUrl = _baseUrl + "uploadImageSection";
    //   dio.options.connectTimeout = 5000; //5s
    //   dio.options.receiveTimeout = 5000;
    //   String fileName = imageFile.name.split('/').last;
      
    //   var formData = FormData.fromMap({
    //     'idUser': user.idUser,
    //     'file': // MultipartFile.fromFile(imageFile.name,filename: fileName)
    //   });
    //   var response = await dio.post(_baseUrl, data: formData);
    //   if (response.statusCode != 200) {
    //     throw Exception("failed to upload");
    //   }
    // }
    // catch(err){
    //   throw Exception(err);
    // } 
  
  // void _chooseFile() {
  //   InputElement uploadInput = FileUploadInputElement();
  //   uploadInput.accept = ".mp4";
  //   uploadInput.multiple = true;
  //   uploadInput.click();
  //   uploadInput.onChange.listen((event) {
  //     final files = uploadInput.files;
  //     if (files.length == 1) {
  //       final file = files[0];
  //       final reader = FileReader();
  //       reader.onLoadEnd.listen((event) {
  //         print('loaded: ${file.name}');
  //         print('type: ${reader.result.runtimeType}');
  //         print('file size = ${file.size}');
  //         _uploadFile(file);
  //       });
  //       reader.onError.listen((event) {
  //         print(event);
  //       });
  //       reader.readAsArrayBuffer(file);
  //     }
  //   });
  // }
    // var stream = new http.ByteStream((imageFile.openRead()));
    // var length = await imageFile.length();

    // var uri = Uri.parse(_baseUrl + 'uploadImageSection');

    // var request = new http.MultipartRequest("POST", uri);
    // var multipartFile = new http.MultipartFile('file', stream, length,
    //     filename: basename(imageFile.path));
    //     //contentType: new MediaType('image', 'png'));

    // request.files.add(multipartFile);
    // var response = await request.send();
    // print(response.statusCode);
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    
}