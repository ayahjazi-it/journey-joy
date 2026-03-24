import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controller.dart';
import 'package:flutter_application_1/view/home_page.dart';
import 'package:flutter_application_1/widget/Textfiledcode.dart';
import 'package:flutter_application_1/widget/signinbutten.dart';
import 'package:get/get.dart';

class Codescreen extends StatelessWidget {
  const Codescreen({super.key});
  static String screenRoot = 'Code_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 140, left: 20),
            child: Text('0994469119',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 10),
            child: Text('11'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )),
          ),
          SizedBox(
            height: 70,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Textfiledcode(
                controller: c1,
                first: true,
                last: false,
              ),
              SizedBox(
                width: 20,
              ),
              Textfiledcode(
                controller: c2,
                first: false,
                last: false,
              ),
              SizedBox(
                width: 20,
              ),
              Textfiledcode(
                controller: c3,
                first: false,
                last: false,
              ),
              SizedBox(
                width: 20,
              ),
              Textfiledcode(
                controller: c4,
                first: false,
                last: true,
              ),
            ],
          ),
          SizedBox(
            height: 120,
          ),
          Signinbutten(
              color: Colors.blue,
              text: '12'.tr,
              hight: 40,
              width: 280,
              onTap: () {
                Navigator.pushNamed(context, homePage.screenRoot);
              }),
        ],
      ),
    );
  }
}
