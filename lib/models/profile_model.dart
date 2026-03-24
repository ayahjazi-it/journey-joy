class profileModel {
  String? name;
  String? mobile;

  profileModel({this.name, this.mobile});

  profileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    return data;
  }
}