class CoffeModel {
  String name;
  String image;
  int id;
  CoffeModel({required this.name, required this.image,required this.id});

  factory CoffeModel.fromJson(Map<String, dynamic> jsonData) {
    return CoffeModel(
      name: jsonData['name'],
      image: jsonData['image'],
      id : jsonData['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
