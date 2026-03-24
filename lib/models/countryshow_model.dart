class CountryShowModel {
  int? id;
  String? name;
  String? continent;
  String? description;
  String? image;
  String? currency;
  String? createdAt;
  String? updatedAt;

  CountryShowModel(
      {required this.id,
      required this.name,
      required this.continent,
      required this.description,
      required this.image,
      required this.currency,
      required this.createdAt,
      required this.updatedAt});

  CountryShowModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    continent = jsonData['continent'];
    description = jsonData['description'];
    image = jsonData['image'];
    currency = jsonData['Currency'];
    createdAt = jsonData['created_at'];
    updatedAt = jsonData['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['continent'] = this.continent;
    data['description'] = this.description;
    data['image'] = this.image;
    data['Currency'] = this.currency;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
