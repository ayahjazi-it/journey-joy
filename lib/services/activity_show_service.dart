import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/activity_show_model.dart';
import 'package:http/http.dart' as http;

class ActivityShowService {
  Future<List<ActivityShowModel>> fetchshowactivity(
    String token,
    int id,
  ) async {
    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/activity/show/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ActivityShowModel> activitesshowlist = data
          .map((activity) => ActivityShowModel.fromJson(activity))
          .toList();
      return activitesshowlist;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
