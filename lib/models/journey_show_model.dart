class JourneyShowModel {
  int? id;
  String? destinationRegionId;
  String? startPlaceRegionId;
  String? residenceHotelId;
  int? userId;
  String? name;
  String? endDate;
  String? startDate;
  String? description;
  int? capacity;
  String? image;
  String? journeyPrice;

  JourneyShowModel(
      {this.id,
        this.destinationRegionId,
        this.startPlaceRegionId,
        this.residenceHotelId,
        this.userId,
        this.name,
        this.endDate,
        this.startDate,
        this.description,
        this.capacity,
        this.image,
        this.journeyPrice,});

  JourneyShowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    destinationRegionId = json['destination_region_id'];
    startPlaceRegionId = json['startPlace_region_id'];
    residenceHotelId = json['Residence_hotel_id'];
    userId = json['user_id'];
    name = json['name'];
    endDate = json['end_date'];
    startDate = json['start_date'];
    description = json['description'];
    capacity = json['capacity'];
    image = json['image'];
    journeyPrice = json['journey_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['destination_region_id'] = this.destinationRegionId;
    data['startPlace_region_id'] = this.startPlaceRegionId;
    data['Residence_hotel_id'] = this.residenceHotelId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['end_date'] = this.endDate;
    data['start_date'] = this.startDate;
    data['description'] = this.description;
    data['capacity'] = this.capacity;
    data['image'] = this.image;
    data['journey_price'] = this.journeyPrice;
    return data;
  }
}