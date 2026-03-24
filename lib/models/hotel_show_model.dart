class HotelshowModel {
  int? id;
  String? name;
  String? location;
  String? category;
  String? phone;
  String? image;
  String? services;


  HotelshowModel({
    required this.id,
    required this.name,
    required this.location,
    required this.category,
    required this.phone,
    required this.image,
    required this.services,
  });

  HotelshowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    category = json['category'];
    phone = json['phone'];
    image = json['image'];
    services = json['services'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['category'] = this.category;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['services'] = this.services;
    return data;
  }
}
