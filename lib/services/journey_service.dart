import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/journey_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AlljourneyService {
  Future<List<JourneyModel>> fetchJourney(String token) async {
    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/hotel/get'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<JourneyModel> journeyList = data
          .map((journey) => JourneyModel.fromJson(journey))
          .toList();
      return journeyList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
