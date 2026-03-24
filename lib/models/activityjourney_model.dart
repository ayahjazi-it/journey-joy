class ActivityJourneyModel {
  int? id;
  int? activityId;
  int? journeyId;
  int? isRequired;
  String? date;
  int? price;

  ActivityJourneyModel(
      {this.id,
        this.activityId,
        this.journeyId,
        this.isRequired,
        this.date,
        this.price,
      });

  ActivityJourneyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityId = json['activity_id'];
    journeyId = json['journey_id'];
    isRequired = json['is_required'];
    date = json['date'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activity_id'] = this.activityId;
    data['journey_id'] = this.journeyId;
    data['is_required'] = this.isRequired;
    data['date'] = this.date;
    data['price'] = this.price;
    return data;
  }
}