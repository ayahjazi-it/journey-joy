import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHome extends StatefulWidget {
  MapHome({super.key});
  static String screenRoot = 'map_screen';

  @override
  State<MapHome> createState() => _HomeState();
}

class _HomeState extends State<MapHome> {
  var mymarkers = HashSet<Marker>(); //colliction
  GoogleMapController? gmc;
  static const LatLng _pGooglePlex = LatLng(36.19948, 37.13863);
  static const LatLng _ApplePark = LatLng(37.19948, 30.13863);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Google Map'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          GoogleMap(
              onTap: (LatLng latLng) {
                print('11111');
                print(latLng);
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  33.5138,
                  36.2765,
                ),
                zoom: 12,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pGooglePlex,
                ),
              }),
        ],
      ),
    );
  }
}
