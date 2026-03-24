import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/activityModel.dart';
import 'package:http/http.dart' as http;

class AllactivityService {
  Future<List<Activities>> fetchActivities(String token) async {
    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/activity/get'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Activities> activitiesList = data
          .map((activity) => Activities.fromJson(activity))
          .toList();
      return activitiesList;
    } else {
      print(response.body);
      throw Exception('Failed to fetch data');
    }
  }
}
