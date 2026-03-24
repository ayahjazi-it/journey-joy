import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/country_model.dart';
import 'package:flutter_application_1/services/Country_Servies.dart';
import 'package:flutter_application_1/widget/countrycard.dart';
import 'country_show_screen.dart';

class CountryListScreen extends StatelessWidget {
  final Allcountry allCountryService = Allcountry();

  // static late SharedPreferences sharedPreferences;
  // static String? getUserToken() {
  //   return sharedPreferences.getString('token');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country List'),
      ),
      body: FutureBuilder<List<CountryModel>>(
        future: allCountryService
            .fetchcountry('1|WWoI8gaKPj6AgNiIgkHLYZT4UwgK3B24XN3vpBhp562649fb'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('false');
            print(snapshot.error);
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            print(snapshot.data);
            List<CountryModel> countres = snapshot.data!;
            return ListView.builder(
              itemCount: countres.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ), // Add horizontal spacing
                  child: Center(
                    child: Countrycard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountryShow(
                              id: countres[index].id,
                            ),
                          ),
                        );
                      },
                      country: countres[index],
                    ),
                  ),
                );
              },
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}
