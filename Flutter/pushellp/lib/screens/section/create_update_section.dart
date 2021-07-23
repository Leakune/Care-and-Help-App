import 'dart:convert';
import 'dart:html'as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:pushellp/commun/utils.dart';
import 'package:pushellp/commun/appBarCustom.dart';
import 'package:pushellp/commun/back_btn_custom.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/models/Section.dart';
import 'package:pushellp/models/User.dart';
import 'package:pushellp/screens/section/abandon_btn.dart';
import 'package:pushellp/screens/section/textFormFieldCustom.dart';
import 'package:pushellp/services/http_service.dart';
import 'package:pushellp/services/upload_service.dart';
import 'package:image_picker/image_picker.dart';

class CreateUpdateSection extends StatefulWidget {
  final User user;
  final bool isCreatePage;
  final Section? section;

  const CreateUpdateSection(
      {Key? key, required this.user, required this.isCreatePage, this.section})
      : super(key: key);

  @override
  _CreateUpdateSectionState createState() => _CreateUpdateSectionState();
}

class _CreateUpdateSectionState extends State<CreateUpdateSection> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _uploadService = UploadService();
  final _httpService = HttpService();
  //File? _pickedImage;
  List<int>? _selectedFile;
  Uint8List? _bytesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: "Manage Sections",
        userPseudo: widget.user.pseudo,
      ),
      drawer: DrawerCustom(
        user: widget.user,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BackButtonCustom(
                  user: widget.user,
                  btnLeadsToHomePage: false,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      widget.isCreatePage
                          ? "Create a section"
                          : "Update a section",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(height: 15),
                    createForm()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form createForm() {
    var valueTitle = "";
    var valueDescription = "";
    var successMessage = "The creation of the section has been successful";
    var errorMessage = "Error creating the section";
    if(!widget.isCreatePage && widget.section != null){
      valueTitle = widget.section!.title;
      valueDescription = widget.section!.description;
      successMessage = "The update of the section has been successful";
      errorMessage = "Error updating the section";
    }
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
              child: CustomTextFormField(controller: _titleController,input: "Title", isDescription: false, value: valueTitle,)
            ),
            SizedBox(height: 15),
            Container(
              child: CustomTextFormField(controller: _descriptionController,input: "Description", isDescription: true, value: valueDescription,)
            ),
            SizedBox(height: 15),
            ElevatedButton(onPressed: startWebFilePicker, child: Text("Upload Image")),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if(_selectedFile == null && widget.isCreatePage){
                        Utils.displayAlertDialog(context, "Error", "Please upload the image related to the section you want to create");
                        return;
                      }
                      try{
                        //await _uploadService.uploadFile(selectedFile: _selectedFile!, bytesData: _bytesData, user: widget.user);
                        if(!widget.isCreatePage && widget.section != null){
                          await _httpService.setSectionById(widget.section!.idSection, _titleController.text.trim(), _descriptionController.text.trim());
                        }else{
                          await _httpService.createSection(_titleController.text.trim(), _descriptionController.text.trim());
                        }                       
                        Utils.displayAlertDialogWithPopUp(context, "Success", successMessage);
                      }catch(err){
                        Utils.displayAlertDialog(context, errorMessage, err.toString());
                      }
                    }
                  },
                  child: Text("Submit"),
                ),
                SizedBox(width: 10),
                AbandonBtn(title: "Abandon", question: "Are you sure you want to abandon the creation of the section?", contextParent: context),
              ],
            )
          ],
        ),
      ),
    );
  }

  void startWebFilePicker() async {
    //InputElement uploadInput = FileUploadInputElement();
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result!);
      });
      reader.readAsDataUrl(file);
    });
  }
  void _handleResult(Object result) {
    _bytesData = Base64Decoder().convert(result.toString().split(",").last);
    _selectedFile = _bytesData;
    
  }

  // Future<void> getImage() async {
  //   // final pickedFile = await ImagePicker().(source: ImageSource.gallery);

  //   // setState(() {
  //   //   if (pickedFile != null) {
  //   //     _pickedImage = File(pickedFile.path);
  //   //   } else {
  //   //     print('No image selected.');
  //   //   }
  //   // });
  //   var fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.file);

  //   if (fromPicker != null) {
  //     setState(() {
  //       _pickedImage = fromPicker as File;
  //     });
  //   }
  // }
}
