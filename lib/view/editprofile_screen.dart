import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/edite_butten.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;

class Editprofile extends StatefulWidget {
  Editprofile({super.key});
  static String screenRoot = 'editprofile_screen';

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/image/photo_2024-08-08_14-45-14.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Center(
                  child: Icon(Icons.person, size: 90, color: Colors.white),
                ),
              ),
              SizedBox(height: 80),
              Expanded(
                child: Stack(
                  children: [
                    Container(decoration: BoxDecoration(color: Colors.white)),
                    ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 40,
                          ),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.blue,
                                ),
                              ),
                              labelText: 'Name'.tr,
                              labelStyle: TextStyle(
                                fontSize: 20,
                                color: Color(0xff034f8d),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 21,
                                color: Color(0xff034f8d),
                              ),
                              suffixIcon: Icon(
                                Icons.person,
                                color: Color(0xff034f8d),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 40,
                          ),
                          child: TextFormField(
                            controller: mobileController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.blue,
                                ),
                              ),
                              labelText: 'Mobile'.tr,
                              labelStyle: TextStyle(
                                fontSize: 20,
                                color: Color(0xff034f8d),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 21,
                                color: Color(0xff034f8d),
                              ),
                              suffixIcon: Icon(
                                Icons.phone_android,
                                color: Color(0xff034f8d),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your mobile number";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 60,
                          ),
                          child: Editbutten(
                            color: Colors.lightBlue,
                            hight: 40,
                            width: 10,
                            text: "Update".tr,
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                int id = 3; // استخدم هنا معرف المستخدم المطلوب
                                updateProfile(
                                  nameController.text,
                                  mobileController.text,
                                  id,
                                  context,
                                );
                              }
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

  void updateProfile(
    String name,
    String mobile,
    int id,
    BuildContext context,
  ) async {
    String token =
        '1|WWoI8gaKPj6AgNiIgkHLYZT4UwgK3B24XN3vpBhp562649fb'; // ضع هنا الـ token الصحيح

    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.142:8000/api/update/$id'),
        body: {'name': name, 'mobile': mobile},
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        showSuccessDialog(context);
      } else {
        print('Failed to update profile. Status code: ${response.statusCode}');
        showErrorDialog(context, 'Failed to update profile. Please try again.');
      }
    } catch (e) {
      print('Error: $e');
      showErrorDialog(context, 'An error occurred. Please try again.');
    }
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 40),
              SizedBox(width: 10),
              Text('Modified successfully', style: TextStyle(fontSize: 18)),
            ],
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 40),
              SizedBox(width: 10),
              Text(message, style: TextStyle(fontSize: 18)),
            ],
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
