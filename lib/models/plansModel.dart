class tripModel {
  final String title;
  final dynamic price;
  final int id;
  final String image;

  tripModel({
    required this.id,
    required this.price,
    required this.title,
    required this.image,
  });

  factory tripModel.fromjson(jsonData) {
    return tripModel(
      id: jsonData['id'],
      title: jsonData['title'],
      image: jsonData['image'],
      price: jsonData['price'],
    );
  }
}
