import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/browse_resservation_model.dart';
import 'package:flutter_application_1/services/browse_resservation_service.dart';
import 'package:flutter_application_1/widget/reserve_card.dart';

class ResservatinListScreen extends StatelessWidget {
  final AllresserveService allresserveService = AllresserveService();
  static String screenRoot = 'restaurant_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ResserationModel>>(
        future: allresserveService.fetchresserve(
          '5|xNut0XJikTIXu4MKMjIQ0HDLUJ8JWHjyFdLP2gJ8db35cb31',
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('false');
            print(snapshot.error);
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            print(snapshot.data);
            List<ResserationModel> resserves = snapshot.data!;
            return ListView.builder(
              itemCount: resserves.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Center(
                    child: reservationcard(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => RestaurantShow(
                        //       id: restaurantes[index].id,
                        //     ),
                        //   ),
                        // );
                      },
                      resserve: resserves[index],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
