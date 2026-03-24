class CountryModel {
  String name;
  String image;
  int id;
  
  CountryModel({required this.name, required this.image,
   required this.id
  });

  factory CountryModel.fromJson(Map<String, dynamic> jsonData) {
    return CountryModel(
      name: jsonData['name'],
      image: jsonData['image'],
       id: jsonData['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
