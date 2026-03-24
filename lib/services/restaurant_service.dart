import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/restaurent_model.dart';
import 'package:http/http.dart' as http;

class Allrestaurant {
  Future<List<RestaurantModel>> fetchrestaurant(String token) async {
    http.Response response = await http.get(
      Uri.parse('http://$localhost:8000/api/restaurant/get'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<RestaurantModel> restauranteslist = [];

      for (int i = 0; i < data.length; i++) {
        restauranteslist.add(RestaurantModel.fromJson(data[i]));
      }

      return restauranteslist;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
