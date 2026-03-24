import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/user_contacts_model.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class AllContactsService {
  static late SharedPreferences sharedPreferences;

  // تهيئة SharedPreferences
  static Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // جلب التوكن من SharedPreferences
  static String? getUserToken() {
    return sharedPreferences.getString('token');
  }

  Future<List<ContactsModel>> fetchcontacts() async {
    // التأكد من وجود التوكن
    final String? token = getUserToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/journey/get'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ContactsModel> contactsList = data
          .map((contacts) => ContactsModel.fromJson(contacts))
          .toList();
      return contactsList;
    } else {
      print(response.body);
      throw Exception('Failed to fetch data');
    }
  }
}
