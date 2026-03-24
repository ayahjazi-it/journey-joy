import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/hotel_model.dart';
import 'package:flutter_application_1/services/hotel_service.dart';
import 'package:flutter_application_1/view/hotel_show_screen.dart';
import 'package:flutter_application_1/widget/hotele_card.dart';

class HotelListScreen extends StatelessWidget {
  final AllhotelService hotelService = AllhotelService();
  static String screenRoot = 'hotel_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hotel List')),
      body: FutureBuilder<List<Hotels>>(
        future: hotelService.fetchHotels(
          '1|WWoI8gaKPj6AgNiIgkHLYZT4UwgK3B24XN3vpBhp562649fb',
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<Hotels> hotels = snapshot.data!;
            return ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Hotelscard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HotelShow(id: hotels[index].id!),
                        ),
                      );
                    },
                    hotel: hotels[index],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
