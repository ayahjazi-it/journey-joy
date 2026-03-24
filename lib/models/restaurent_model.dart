class RestaurantModel {
  String name;
  String image;
  int id;
  RestaurantModel({required this.name, required this.image,required this.id});

  factory RestaurantModel.fromJson(Map<String, dynamic> jsonData) {
    return RestaurantModel(
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
