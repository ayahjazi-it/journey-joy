class RestaurantShowModel{
  int? id;
  String? name;
  // int? region_Id;
  String? location;
  String? category;
  String? phone;
  String? image;

  RestaurantShowModel(
      { required this.id,
        required this.name,
        // required this.region_Id,
        required this.location,
        required this.category,
        required this.phone,
        required this.image,});

  RestaurantShowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // region_Id = json['region_id'];
    location = json['location'];
    category = json['category'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    // data['region_id'] = this.region_Id;
    data['location'] = this.location;
    data['category'] = this.category;
    data['phone'] = this.phone;
    data['image'] = this.image;
    return data;
  }
}