import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/hotel_model.dart';
import 'package:http/http.dart' as http;

class AllhotelService {
  Future<List<Hotels>> fetchHotels(String token) async {
    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/hotel/get'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Hotels> hotelsList = data
          .map((hotel) => Hotels.fromJson(hotel))
          .toList();
      return hotelsList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
