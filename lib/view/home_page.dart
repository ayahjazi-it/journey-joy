import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_application_1/models/plansModel.dart';
import 'package:flutter_application_1/view/browse_resservation_service.dart';
import 'package:flutter_application_1/view/country_list_screen.dart';
import 'package:flutter_application_1/view/page1.dart';
import 'package:flutter_application_1/view/search_screen.dart';
import 'package:get/get.dart';

class homePage extends StatefulWidget {
  static String screenRoot = 'home_screen';
  // const homePage({super.key});
  final List<tripModel> favorittrip;

  const homePage({super.key, required this.favorittrip});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GlobalKey<ScaffoldState> scafoldkey = GlobalKey();
  int selectedindex = 0;

  List<Widget> listwidg = [
    Page1(),
    CountryListScreen(),
    ResservatinListScreen(),
    // Googlemap(),
    JourneySearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            selectedindex = value;
          });
        },
        currentIndex: selectedindex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: const Color.fromARGB(255, 41, 239, 48),
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "14".tr),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_rounded),
            label: "15".tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Reservations",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "17".tr),
        ],
      ),
      body: Container(child: listwidg.elementAt(selectedindex)),
    );
  }
}
