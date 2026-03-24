import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/view/codescreen.dart';
import 'package:flutter_application_1/widget/signinbutten.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Registerscreen extends StatefulWidget {
  Registerscreen({super.key});
  static String screenRoot = 'register1_screen';

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  //تابع الربط
  void Register(String name, String mobile, String password) async {
    Map<String, dynamic> headers = {};
    String? token;
    // if (token != null) {
    //   headers.addAll({'Authorization': 'Bearer $token'});
    // }
    try {
      print('try');
      final response = await http.post(
        Uri.parse('http://$localhost:8000/api/register'),
        body: {'name': name, 'mobile': mobile, 'password': password},
        headers: {'Authorization': 'Bearer $token'},
      );
      print('end');

      if (response.statusCode == 200) {
        print('body = ${response.body}');
        Navigator.pushReplacementNamed(context, Codescreen.screenRoot);
      } else {
        //  تعامل مع خطأ الإرسال
        print('Error : ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/image/photo_2024-03-25_21-51-13.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(height: 150),
              Icon(Icons.account_circle, size: 95, color: Colors.white),
              SizedBox(height: 40),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 4),
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                    ),
                    ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 25,
                            left: 40,
                            right: 40,
                          ),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              //  hintText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.blue,
                                ),
                              ),
                              //when click it
                              label: Text(
                                '7'.tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff034f8d),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 21,
                                color: Color(0xff034f8d),
                              ),
                              suffixIconColor: Color(0xff034f8d),
                              suffixIcon: Icon(
                                Icons.person,
                                //Icons.lock_outline
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your Data";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40,
                            left: 40,
                            right: 40,
                          ),
                          child: TextFormField(
                            controller: mobileController,
                            decoration: InputDecoration(
                              //  hintText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.blue,
                                ),
                              ),
                              //when click it
                              label: Text(
                                '8'.tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff034f8d),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 21,
                                color: Color(0xff034f8d),
                              ),
                              suffixIconColor: Color(0xff034f8d),
                              suffixIcon: Icon(
                                Icons.phone_android,
                                //Icons.lock_outline
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your Data";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40,
                            left: 40,
                            right: 40,
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              //  hintText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.blue,
                                ),
                              ),
                              //when click it
                              label: Text(
                                '9'.tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff034f8d),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 21,
                                color: Color(0xff034f8d),
                              ),
                              suffixIconColor: Color(0xff034f8d),
                              suffixIcon: Icon(
                                Icons.lock_outline,
                                //Icons.lock_outline
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your Data";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            left: 60,
                            right: 60,
                            bottom: 4,
                          ),
                          child: Signinbutten(
                            color: Colors.lightBlue,
                            hight: 40,
                            width: 100,
                            text: "10".tr,
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                //regester
                                print('ffff');
                                Register(
                                  mobileController.text,
                                  nameController.text,
                                  passwordController.text,
                                );
                              }
                              print('333');
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
