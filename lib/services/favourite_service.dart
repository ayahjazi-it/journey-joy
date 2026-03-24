import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/journey_model.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class FavouriteService {
  late SharedPreferences sharedPreferences;

  // تهيئة SharedPreferences
  Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // دالة لجلب التوكن من SharedPreferences
  String? getUserToken() {
    return sharedPreferences.getString('token');
  }

  // دالة لجلب العناصر المفضلة
  Future<List<JourneyModel>> fetchFavourite() async {
    await initSharedPreferences(); // تأكد من تهيئة sharedPreferences
    final String? token = getUserToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/users/favorites'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<JourneyModel> journeyList = data
          .map((journey) => JourneyModel.fromJson(journey))
          .toList();
      return journeyList;
    } else {
      print(response.body);
      throw Exception('Failed to fetch data');
    }
  }

  // دالة لإضافة عنصر إلى المفضلة
  Future<void> addFavorite(String journeyId) async {
    await initSharedPreferences(); // تأكد من تهيئة sharedPreferences
    final String? token = getUserToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    final response = await http.post(
      Uri.parse('http://192.168.43.142:8000/api/favorites'),
      headers: {'Authorization': 'Bearer $token'},
      body: {'journey_id': journeyId},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add favorite');
    }
  }

  // دالة لحذف عنصر من المفضلة
  Future<void> removeFavorite(String journeyId) async {
    await initSharedPreferences(); // تأكد من تهيئة sharedPreferences
    final String? token = getUserToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.delete(
      Uri.parse('http://192.168.43.142:8000/api/favorites/$journeyId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove favorite');
    }
  }
}
