class AirlineshowModel {
  int? id;
  String? name;
  String? email;
  String? location;
  String? image;
  String? mobile;

  AirlineshowModel(
      {required this.id,
       required this.name,
        required   this.email,
        required this.location,
        required this.image,
        required this.mobile,
     });

  AirlineshowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    location = json['location'];
    image = json['image'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['location'] = this.location;
    data['image'] = this.image;
    data['mobile'] = this.mobile;
    return data;
  }
}