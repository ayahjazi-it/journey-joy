import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/profile_model.dart';
import 'package:http/http.dart' as http;


class profileService {
  Future<List<profileModel>> fetchprofile(int id) async {
    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/profile/$id'), 
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<profileModel> profileList = data.map((profile) => profileModel.fromJson(profile)).toList();
      return profileList;
    } else {
      print(response.body);
      throw Exception('Failed to fetch data');
    }
  }
}
