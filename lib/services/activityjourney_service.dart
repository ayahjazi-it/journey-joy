import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/activityjourney_model.dart';
import 'package:http/http.dart' as http;

class ActivityJourneyService {
  Future<List<ActivityJourneyModel>> fetchactivityjourney(
    String token,
    int id,
  ) async {
    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/hotel/show/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ActivityJourneyModel> activityjourneylist = data
          .map(
            (activityjourney) => ActivityJourneyModel.fromJson(activityjourney),
          )
          .toList();
      return activityjourneylist;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
