import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/restaurant_show_model.dart';
import 'package:flutter_application_1/services/restaurantshow_service.dart';


class RestaurantShow extends StatelessWidget {
  final RestaurantShowService allshowrestaurant = RestaurantShowService();
  final int id;
  RestaurantShow({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<RestaurantShowModel>>(
        future: allshowrestaurant.fetchshowrestaurant(
          '1|WWoI8gaKPj6AgNiIgkHLYZT4UwgK3B24XN3vpBhp562649fb',
          id, // استخدام معرف البلد
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<RestaurantShowModel> restaurantes = snapshot.data!;
            return ListView.builder(
              itemCount: restaurantes.length,
              itemBuilder: (context, index) {
                RestaurantShowModel restaurant = restaurantes[index];
                return Column(
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(restaurant.image ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 200),
                      child: Text(
                        restaurant.name ?? '',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 170),
                      child: Text(
                        restaurant.category ?? '',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40, right: 60, left: 20),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 30,
                                color: Colors.blue,
                              ),
                              Text(restaurant.phone ?? ''),
                            ],
                          ),
                          SizedBox(width: 60),
                          // Column(
                          //   children: [
                          //     Icon(
                          //       Icons.u_turn_right,
                          //       size: 30,
                          //       color: Colors.blue,
                          //     ),
                          //     // Text(restaurant.regionId.toString() ?? ''),
                          //   ],
                          // ),
                          SizedBox(width: 60),
                          Column(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 30,
                                color: Colors.blue,
                              ),
                              Text(restaurant.location ?? ''),
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
