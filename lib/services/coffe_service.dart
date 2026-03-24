import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/coffe_model.dart';
import 'package:http/http.dart' as http;

class Allcoffe {
  Future<List<CoffeModel>> fetchcoffe(String token) async {
    http.Response response = await http.get(
      Uri.parse('http://$localhost:8000/api/cafe/get'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<CoffeModel> coffeslist = [];

      for (int i = 0; i < data.length; i++) {
        coffeslist.add(CoffeModel.fromJson(data[i]));
      }

      return coffeslist;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
