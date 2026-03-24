import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/journey_activites_required_model.dart';
import 'package:http/http.dart' as http;

class AllActivityoptional {
  Future<List<ActiviyyRequiredModel>> fetchactivityoptional(
    String token,
    int id,
  ) async {
    http.Response response = await http.get(
      Uri.parse('http://$localhost:8000/api/journeyActivities/optional/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> data = jsonDecode(response.body);
      List<ActiviyyRequiredModel> activityoptionallist = [];

      for (var item in data) {
        activityoptionallist.add(ActiviyyRequiredModel.fromJson(item));
      }

      return activityoptionallist;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
