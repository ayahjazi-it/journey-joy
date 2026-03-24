import 'dart:convert';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/browse_resservation_model.dart';
import 'package:http/http.dart' as http;

class AllresserveService {
  Future<List<ResserationModel>> fetchresserve(String token) async {
    final response = await http.get(
      Uri.parse('http://$localhost:8000/api/reservation/user'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ResserationModel> resserveList = data
          .map((resserveList) => ResserationModel.fromJson(resserveList))
          .toList();
      return resserveList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
