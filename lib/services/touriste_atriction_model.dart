import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/touriste_atriction_model.dart';
import 'package:http/http.dart' as http;

class AllTouresteService {
  Future<List<TouristeModel>> fetchtoureste(String token) async {
    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/journey/get'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<TouristeModel> touresteList = data
          .map((tourest) => TouristeModel.fromJson(tourest))
          .toList();
      return touresteList;
    } else {
      print(response.body);
      throw Exception('Failed to fetch data');
    }
  }
}
