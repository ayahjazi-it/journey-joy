class ActivityModel {
  Activities? activities;

  ActivityModel({this.activities});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    activities = json['activities'] != null
        ? Activities.fromJson(json['activities'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (activities != null) {
      data['activities'] = activities!.toJson();
    }
    return data;
  }
}

class Activities {
  String? name;
  String? details;
  String? image;
  int? id;

  Activities({
    this.name,
    this.details,
    this.image,
    this.id,
  });

  Activities.fromJson(Map<String, dynamic> json) {
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
