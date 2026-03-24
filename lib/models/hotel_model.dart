class HotelModel {
  Hotels? hotels;

  HotelModel({this.hotels});

  HotelModel.fromJson(Map<String, dynamic> json) {
    hotels =
    json['hotels'] != null ? new Hotels.fromJson(json['hotels']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotels != null) {
      data['hotels'] = this.hotels!.toJson();
    }
    return data;
  }
}

class Hotels {
  String? name;
  String? location;
  String? category;
  String? image;
  String? services;
  String? phone;
  String? updatedAt;
  String? createdAt;
  int? id;

  Hotels(
      {this.name,
        this.location,
        this.category,
        this.image,
        this.services,
        this.phone,
        this.updatedAt,
        this.createdAt,
        this.id});

  Hotels.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    category = json['category'];
    image = json['image'];
    services = json['services'];
    phone = json['phone'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['location'] = this.location;
    data['category'] = this.category;
    data['image'] = this.image;
    data['services'] = this.services;
    data['phone'] = this.phone;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}