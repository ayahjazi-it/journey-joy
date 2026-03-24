import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/countryshow_model.dart';
import 'package:flutter_application_1/services/countryshow_service.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CountryShow extends StatelessWidget {
  final CountryShowService allshowcountry = CountryShowService();
  final int id;

  CountryShow({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      // ),
      body: FutureBuilder<List<CountryShowModel>>(
        future: allshowcountry.fetchshowcountry(
          '1|WWoI8gaKPj6AgNiIgkHLYZT4UwgK3B24XN3vpBhp562649fb',
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
            List<CountryShowModel> countries = snapshot.data!;
            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                CountryShowModel country = countries[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      // width: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(country.image ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        country.name ?? '',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Text(
                        '36'.tr,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Text(country.description ?? ''),
                    ),
                    SizedBox(height: 30),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Text(
                        '37'.tr,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Text(country.continent ?? ''),
                    ),
                    SizedBox(height: 15),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Text(
                        '38'.tr,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Text(country.currency ?? ''),
                    ),
                    SizedBox(height: 15),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Text(
                        '39'.tr,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(33.5138, 36.2765),
                            zoom: 12,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId("_currentLocation"),
                              icon: BitmapDescriptor.defaultMarker,
                              position: LatLng(36.19948, 37.13863),
                            ),
                          },
                        ),
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
