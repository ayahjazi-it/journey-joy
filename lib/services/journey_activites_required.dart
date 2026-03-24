import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/journey_activites_required_model.dart';
import 'package:http/http.dart' as http;

class AllActivityRequired {
  Future<List<ActiviyyRequiredModel>> fetchactivityrequired(
    String token,
    int id,
  ) async {
    http.Response response = await http.get(
      Uri.parse('http://$localhost:8000/api/journeyActivities/required/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ActiviyyRequiredModel> activityrequiredlist = [];

      for (var item in data) {
        activityrequiredlist.add(ActiviyyRequiredModel.fromJson(item));
      }

      return activityrequiredlist;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
