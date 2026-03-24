import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/restaurant_show_model.dart';
import 'package:http/http.dart' as http;

class RestaurantShowService {
  Future<List<RestaurantShowModel>> fetchshowrestaurant(
    String token,
    int id,
  ) async {
    http.Response response = await http.get(
      Uri.parse('http://$localhost:8000/api/restaurant/show/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<RestaurantShowModel> restaurantesshowlist = [];

      for (int i = 0; i < data.length; i++) {
        restaurantesshowlist.add(RestaurantShowModel.fromJson(data[i]));
      }

      return restaurantesshowlist;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
