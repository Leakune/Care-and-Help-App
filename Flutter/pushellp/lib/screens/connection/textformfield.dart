import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String input;
  final bool isPassword;
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.input, required this.isPassword,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: input,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your " + input.toLowerCase();
        }
        return null;
      },
      obscureText: isPassword,
    );
  }
}
