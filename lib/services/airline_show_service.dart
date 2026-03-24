import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/airline_show_model.dart';
import 'package:http/http.dart' as http;

class AirlineshowService {
  Future<List<AirlineshowModel>> fetchairlineshow(String token, int id) async {
    http.Response response = await http.get(
      Uri.parse('http://$localhost:8000/api/AirFlight/show/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<AirlineshowModel> airlineshowlist = [];

      for (int i = 0; i < data.length; i++) {
        airlineshowlist.add(AirlineshowModel.fromJson(data[i]));
      }

      return airlineshowlist;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
