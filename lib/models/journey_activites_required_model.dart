class ActiviyyRequiredModel {
  int? id;
  String? activity_name;
  int? activityId;
  int? journeyId;
  int? isRequired;
  String? date;
  int? price;


  ActiviyyRequiredModel(
      {this.id,
        this.activityId,
        this.journeyId,
        this.isRequired,
        this.date,
        this.price,
        this.activity_name
        });

  ActiviyyRequiredModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityId = json['activity_id'];
    journeyId = json['journey_id'];
    isRequired = json['is_required'];
    date = json['date'];
    price = json['price'];
    activity_name = json['activity_name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activity_id'] = this.activityId;
    data['journey_id'] = this.journeyId;
    data['is_required'] = this.isRequired;
    data['date'] = this.date;
    data['price'] = this.price;
    data['activity_name'] = this.activity_name;
    return data;
  }
}