import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/airline_model.dart';
import 'package:http/http.dart' as http;

class AllairlineService {
  Future<List<AirlineModel>> fetchairline(String token) async {
    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/activity/get'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<AirlineModel> airlineList = data
          .map((airlineList) => AirlineModel.fromJson(airlineList))
          .toList();
      return airlineList;
    } else {
      print(response.body);
      throw Exception('Failed to fetch data');
    }
  }
}
