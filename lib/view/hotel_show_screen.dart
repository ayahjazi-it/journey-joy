import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/hotel_show_model.dart';
import 'package:flutter_application_1/services/hotel_show_service.dart';

class HotelShow extends StatelessWidget {
  final HotelShowService allshowhotel = HotelShowService();
  final int id;

  HotelShow({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hotel Details')),
      body: FutureBuilder<List<HotelshowModel>>(
        future: allshowhotel.fetchshowhotel(
          '6|aPKLX6H0wvPXtwPAFfXo6ly7xOO6Yy1rZvqvuRgh9e08d845',
          id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<HotelshowModel> hotels = snapshot.data!;
            return ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                HotelshowModel hotel = hotels[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(hotel.image ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 16,
                        right: 16,
                      ),
                      child: Text(
                        hotel.name ?? '',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      child: Text(
                        hotel.category ?? '',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          Text('Service:', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 5),
                          Text(
                            hotel.services ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.phone, size: 30, color: Colors.blue),
                              SizedBox(height: 5),
                              Text(
                                hotel.phone ?? '',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 30,
                                color: Colors.blue,
                              ),
                              SizedBox(height: 5),
                              Text(
                                hotel.location ?? '',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
