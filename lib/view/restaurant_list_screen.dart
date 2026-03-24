import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/coffe_model.dart';
import 'package:flutter_application_1/models/restaurent_model.dart';
import 'package:flutter_application_1/services/coffe_service.dart';
import 'package:flutter_application_1/services/restaurant_service.dart';
import 'package:flutter_application_1/widget/coffe_card.dart';
import 'package:flutter_application_1/widget/restaurantcard.dart';

class RestaurantListScreen extends StatelessWidget {
  static String screenRoot = 'resturant_screen';
  Allrestaurant allresturant = Allrestaurant();
  Allcoffe allcoffe = Allcoffe();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Restaurants and Cafes'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Restaurants'),
              Tab(text: 'Cafes'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // محتوى صفحة المطاعم
            Center(
              child: FutureBuilder<List<RestaurantModel>>(
                future: allresturant.fetchrestaurant(
                    '3|aUsbARf3ghMYGf9MVm5WSG9oUAwXbQ36bsXlzwFu81e98c80'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    List<RestaurantModel> restaurants = snapshot.data!;
                    return ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 20.0,
                          ),
                          child: RestaurantCard(
                            onTap: () {
                              // يمكنك استخدام هذا المكان للتنقل إلى صفحة تفاصيل المطعم أو تنفيذ أي عملية أخرى عند النقر على البطاقة
                            },
                            restaurant: restaurants[index],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            // محتوى صفحة المقاهي
            Center(
              child: FutureBuilder<List<CoffeModel>>(
                future: allcoffe.fetchcoffe(
                    '3|aUsbARf3ghMYGf9MVm5WSG9oUAwXbQ36bsXlzwFu81e98c80'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    List<CoffeModel> coffes = snapshot.data!;
                    return ListView.builder(
                      itemCount: coffes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 20.0,
                          ),
                          child: Coffecard(
                            onTap: () {
                              // يمكنك استخدام هذا المكان للتنقل إلى صفحة تفاصيل المطعم أو تنفيذ أي عملية أخرى عند النقر على البطاقة
                            },
                            coffes: coffes[index],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
