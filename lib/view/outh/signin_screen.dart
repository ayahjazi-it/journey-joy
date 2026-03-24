import 'dart:convert';
// import 'dart:js';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/helper/cash_helper.dart';
import 'package:flutter_application_1/view/home_page.dart';
import 'package:flutter_application_1/view/outh/register_screen.dart';
import 'package:flutter_application_1/widget/signinbutten.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  static String screenRoot = 'sign_screen';
  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  CashHelper cashHelper = CashHelper();
  static late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  static Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveUserToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  static String? getUserToken() {
    return sharedPreferences.getString('token');
  }

  //تابع الربط
  void login(String mobile, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.155:8000/api/login'),
        body: {'mobile': mobile, 'password': password},
      );

      if (response.statusCode == 200) {
        // Parse the response body
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Print the full response to debug
        print('Response data: $responseData');

        // Check if the response contains a token inside the "data" object
        if (responseData.containsKey('data') &&
            responseData['data'].containsKey('token')) {
          String token = responseData['data']['token'];
          CashHelper.putUser(userToken: "");

          CashHelper.putUser(userToken: token);
          // CashHelper.getUserToken();

          // Save the token using SharedPreferences
          await saveUserToken(token);

          // Print the token to confirm it was saved
          print('Token saved: $token');

          // Navigate to Admin page
          Navigator.pushReplacementNamed(context, homePage.screenRoot);
        } else {
          // Handle case where token is missing
          print('Token not found in the response.');
        }

        // Login successful
        print('Login successfully');
      } else {
        // Handle login error with detailed response
        print('Error login: ${response.statusCode}');
        print('Error response: ${response.body}');
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
            image: AssetImage('asset/image/photo_2024-03-24_16-15-42.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Lottie.asset(
                'lottei/Animation - 1710964081992.json',
                height: 300,
                width: 300,
              ),
              SizedBox(height: 2),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 4),
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 100,
                            top: 20,
                            right: 100,
                          ),
                          child: SizedBox(
                            child: DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(0xff034f8d),
                              ),
                              child: AnimatedTextKit(
                                animatedTexts: [TyperAnimatedText('1'.tr)],
                              ),
                            ),
                          ),
                        ),

                        // TextFormFieldحقول ال
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 35,
                            left: 40,
                            right: 40,
                          ),
                          child: TextFormField(
                            // key: mobiledFormKey,
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
                                '2'.tr,
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
                                return "this filed is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            left: 40,
                            right: 40,
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.blue,
                                ),
                              ),
                              //when click it
                              label: Text(
                                '3'.tr,
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
                              suffixIcon: Icon(Icons.lock_open_rounded),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter your Data";
                              }
                              return null;
                            },
                          ),
                        ),
                        // زر تسجيل الدخول
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 33,
                            left: 20,
                            right: 20,
                          ),
                          child: Signinbutten(
                            color: Color(0xff1194ff),
                            text: '4'.tr,
                            hight: 40,
                            width: 470,
                            onTap: () {
                              print('222');
                              // login(mobileController.text,passwordController.text);
                              Navigator.pushReplacementNamed(
                                context,
                                homePage.screenRoot,
                              );
                              print('succes');
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "5".tr,
                            style: TextStyle(
                              color: Color(0xff034f8d),
                              fontSize: 15,
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        //زر انشاء الحساب
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Registerscreen.screenRoot,
                              );
                            },
                            child: Text(
                              '6'.tr,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromARGB(255, 1, 26, 46),
                                fontSize: 15,
                              ),
                            ),
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
