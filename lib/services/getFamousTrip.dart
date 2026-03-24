import 'package:flutter_application_1/helper/api.dart';
import 'package:flutter_application_1/models/plansModel.dart';

class AllPlansService {
  Future<List<tripModel>> getAllPlans() async {
    List<dynamic> data = await api().get(
      url: 'https://fakestoreapi.com/products',
    );
    List<tripModel> productsList = [];
    for (int i = 0; i < data.length; i++) {
      productsList.add(tripModel.fromjson(data[i]));
    }

    return productsList;
  }
}
