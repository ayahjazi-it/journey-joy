import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/countryshow_model.dart';
import 'package:http/http.dart' as http;

class CountryShowService {
  Future<List<CountryShowModel>> fetchshowcountry(String token, int id) async {
    http.Response response = await http.get(
      Uri.parse('http://$localhost:8000/api/country/show/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<CountryShowModel> countresshowlist = [];

      for (int i = 0; i < data.length; i++) {
        countresshowlist.add(CountryShowModel.fromJson(data[i]));
      }

      return countresshowlist;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
