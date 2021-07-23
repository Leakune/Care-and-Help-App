import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String value;
  final String input;
  final bool isDescription;
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.input,
    required this.value, required this.isDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isDescription){
      return TextFormField(
        maxLines: null,
        maxLength: 500,
        keyboardType: TextInputType.multiline,
        controller: controller..text = value,
        decoration: InputDecoration(
          hintText: input,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter the " + input.toLowerCase();
          }
          return null;
        },
      );
    }else{
      return TextFormField(
        controller: controller..text = value,
        decoration: InputDecoration(
          hintText: input,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter the " + input.toLowerCase();
          }
          return null;
        },
      );
    }
  }
}
