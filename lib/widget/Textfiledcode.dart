import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Textfiledcode extends StatelessWidget {
  bool first;
  bool last;
  TextEditingController controller;
  Textfiledcode({
    required this.first,
    required this.last,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white30,
      ),
      child: TextFormField(
        onChanged: (value) {
          if (value.isNotEmpty && last == false) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
          ;
        },
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).width / 7,
            maxWidth: MediaQuery.sizeOf(context).width / 7,
          ),
        ),
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
