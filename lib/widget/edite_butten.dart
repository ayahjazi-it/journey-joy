// ignore: unused_import
// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class Editbutten extends StatelessWidget {
  Editbutten(
      {required this.hight,
      required this.width,
      required this.text,
      this.onTap,
      this.color});
  double? hight;
  double? width;
  String text;
  VoidCallback? onTap;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Container(
          height: hight,
          width: width,
          child: Center(
              child: Text(
            text,
            style: TextStyle(fontSize: 21, color: Colors.white),
          )),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
