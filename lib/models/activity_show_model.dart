class ActivityShowModel {
  String? name;
  String? details;
  String? image;
  int? id;

  ActivityShowModel({
    this.name,
    this.details,
    this.image,
    this.id,
  });

  ActivityShowModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    details = json['details'];
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['details'] = details;
    data['image'] = image;
    data['id'] = id;
    return data;
  }
}
