import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.hintText,
      this.onChanged,
      this.obscureText = false,
      this.inputType});
  Function(String)? onChanged;
  String? hintText;
  TextInputType? inputType;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      obscureText: obscureText!,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(), borderRadius: BorderRadius.circular(8)),
        border: OutlineInputBorder(
            borderSide: BorderSide(), borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
