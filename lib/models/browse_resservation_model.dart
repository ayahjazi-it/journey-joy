class ResserationModel {
  int? id;
  int? journeyId;
  String? totalPrice;
  String? state;
  String? paymentState;
  String? journeyName;

  ResserationModel(
      {this.id,
        this.journeyId,
        this.totalPrice,
        this.state,
        this.paymentState,
        this.journeyName});

  ResserationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    journeyId = json['journey_id'];
    totalPrice = json['total_price'];
    state = json['state'];
    paymentState = json['payment_state'];
    journeyName = json['journey_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['journey_id'] = this.journeyId;
    data['total_price'] = this.totalPrice;
    data['state'] = this.state;
    data['payment_state'] = this.paymentState;
    data['journey_name'] = this.journeyName;
    return data;
  }
}