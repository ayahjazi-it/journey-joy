import 'package:flutter/material.dart';

class TextFromFiled1 extends StatelessWidget {
  TextFromFiled1({
    required this.text,
    required this.controller,
    required this.iconData,
  });
  String text;
  TextEditingController controller;
  IconData iconData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        //  hintText: 'Password',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 3, color: Colors.blue),
        ),
        //when click it
        label: Text(
          text,
          style: TextStyle(fontSize: 20, color: Color(0xff034f8d)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        hintStyle: TextStyle(fontSize: 21, color: Color(0xff034f8d)),
        suffixIconColor: Color(0xff034f8d),
        suffixIcon: Icon(
          iconData,
          //Icons.lock_outline
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "please enter your Data";
        }
        return null;
      },
    );
  }
}
