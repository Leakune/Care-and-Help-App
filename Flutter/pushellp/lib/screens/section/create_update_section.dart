import 'package:flutter/material.dart';
import 'package:pushellp/commun/appBarCustom.dart';
import 'package:pushellp/commun/back_btn_custom.dart';
import 'package:pushellp/commun/drawerCustom.dart';
import 'package:pushellp/models/User.dart';

class CreateUpdateSection extends StatefulWidget {
  final User user;
  final bool isCreatePage;

  const CreateUpdateSection({Key? key, required this.user, required this.isCreatePage}) : super(key: key);

  @override
  _CreateUpdateSectionState createState() => _CreateUpdateSectionState();
}

class _CreateUpdateSectionState extends State<CreateUpdateSection> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  //final _descriptionController = TextEditingController();

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
                      widget.isCreatePage ? "Create a section" : "Update a section",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(height: 15),
                    createForm()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Form createForm(){
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
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the title";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
