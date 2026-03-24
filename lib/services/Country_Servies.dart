import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/country_model.dart';
import 'package:http/http.dart' as http;

class Allcountry {
  Future<List<CountryModel>> fetchcountry(String token) async {
    http.Response response = await http.get(
      Uri.parse('http://$localhost:8000/api/country/get'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<CountryModel> countreslist = [];

      for (int i = 0; i < data.length; i++) {
        countreslist.add(CountryModel.fromJson(data[i]));
      }

      return countreslist;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
