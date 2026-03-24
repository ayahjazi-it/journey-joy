import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/hotel_show_model.dart';
import 'package:http/http.dart' as http;

class HotelShowService {
  Future<List<HotelshowModel>> fetchshowhotel(String token, int id) async {
    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/hotel/show/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<HotelshowModel> hotelesshowlist = data
          .map((hotel) => HotelshowModel.fromJson(hotel))
          .toList();
      return hotelesshowlist;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
