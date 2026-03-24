import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/locale/locale_controllar.dart';
import 'package:flutter_application_1/models/journey_model.dart';
import 'package:flutter_application_1/models/profile_model.dart';
import 'package:flutter_application_1/povider/mode_provider.dart';
import 'package:flutter_application_1/services/journey_service.dart';
import 'package:flutter_application_1/services/profile_service.dart';
import 'package:flutter_application_1/view/Airlines_screen.dart';
import 'package:flutter_application_1/view/activity_screen.dart';
import 'package:flutter_application_1/view/editprofile_screen.dart';
import 'package:flutter_application_1/view/favorite.dart';
import 'package:flutter_application_1/view/hotel_list_screen.dart';
import 'package:flutter_application_1/view/journey_show_screen.dart';
import 'package:flutter_application_1/view/myjourney_screen.dart';
import 'package:flutter_application_1/view/restaurant_list_screen.dart';
import 'package:flutter_application_1/widget/journey_card.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Page1 extends StatefulWidget {
  Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final AlljourneyService allJourney = AlljourneyService();
  profileService profileservice = profileService();
  late int profileid;
  static late SharedPreferences sharedPreferences;

  // Get token from SharedPreferences
  static String? getUserToken() {
    return sharedPreferences.getString('token');
  }

  // Initialize SharedPreferences
  static Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    Mylocalecontrollar controllarLang = Get.find();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, FavoritesPage.screenRoot);
              },
              icon: Icon(
                Icons.favorite_border,
                color: Colors.blue,
                size: 27,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        leadingWidth: 100,
        title: Text(
          "Journey Joy",
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.4, 0.8],
              colors: [Colors.lightBlue, Colors.white10, Colors.lightBlue],
            ),
          ),
          child: FutureBuilder<List<profileModel>>(
            future: profileservice.fetchprofile(2),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                final profile =
                    snapshot.data![0]; // الحصول على أول عنصر في القائمة
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "asset/image/أين_تقع_جزر_المالديف_بأي_دولة.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      accountName: Text(
                        profile.name ?? 'Name not available',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      accountEmail: Text(
                        profile.mobile ?? 'Mobile not available',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    ListTile(
                      title: Text("25".tr),
                      leading: Icon(Icons.phone_android),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("24".tr),
                      leading: Icon(Icons.flag),
                      onTap: () {},
                    ),
                    Divider(
                      indent: 50,
                      endIndent: 50,
                      color: Colors.grey,
                    ),
                    ListTile(
                      title: Text("27".tr),
                      leading: Icon(Icons.help),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("28".tr),
                      leading: Icon(Icons.language),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("30".tr),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Assumes you have a method to change language
                                    // controllarLang.changelang('en');
                                  },
                                  child: Text("23".tr),
                                ),
                                SizedBox(width: 30),
                                ElevatedButton(
                                  onPressed: () {
                                    // Assumes you have a method to change language
                                    // controllarLang.changelang('ar');
                                  },
                                  child: Text("22".tr),
                                ),
                                SizedBox(width: 25),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    ListTile(
                      title: Text("35".tr),
                      leading: Icon(Icons.edit),
                      onTap: () {
                        Navigator.pushNamed(context, Editprofile.screenRoot);
                      },
                    ),
                    ListTile(
                      title: Text("Dark".tr),
                      leading: Icon(Icons.dark_mode),
                      onTap: () {
                        Provider.of<ModeProvider>(context, listen: false)
                            .changeMode();
                      },
                    ),
                    ListTile(
                      title: Text("Wallet".tr),
                      leading: Icon(Icons.wallet),
                      onTap: () {
                        showSuccessDialog(context);
                      },
                    ),
                    ListTile(
                      title: Text("29".tr),
                      leading: Icon(Icons.exit_to_app),
                      onTap: () {},
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Image.asset(
                      "asset/image/أين_تقع_جزر_المالديف_بأي_دولة.jpg",
                      fit: BoxFit.cover,
                      height: 250,
                      width: 358,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 19),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      height: 203,
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 22,
                              right: 22,
                            ),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AirlinesScreen.screenRoot,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.flight,
                                    color: Colors.blue,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "18".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(
                                  color: Colors.red,
                                  thickness: 60,
                                  indent: 30,
                                  endIndent: 30,
                                  height: 16,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      HotelListScreen.screenRoot,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.home_outlined,
                                    color: Colors.blue,
                                    size: 45,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "19".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 22, top: 8, right: 22),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      RestaurantListScreen.screenRoot,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.restaurant_menu_sharp,
                                    color: Colors.blue,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "20".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      ActivityListScreen.screenRoot,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.nordic_walking_rounded,
                                    color: Colors.blue,
                                    size: 45,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "21".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 230),
                  child: Text(
                    '31'.tr,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    height:
                        200.0, // تعيين ارتفاع الحاوية (ثابت لأنه سيكون محدود العرض)
                    child:
                        // تهيئة SharedPreferences انتهت بنجاح، الآن يمكننا استدعاء API
                        FutureBuilder<List<JourneyModel>>(
                      future: AlljourneyService().fetchJourney(
                          '80|q62Nh17aUhJIBf4qvqKoBgiWc0tHNuH0dSb62Y3c647e11f0'),
                      builder: (context, journeySnapshot) {
                        if (journeySnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (journeySnapshot.hasError) {
                          return Center(
                              child: Text('Error: ${journeySnapshot.error}'));
                        } else if (journeySnapshot.hasData &&
                            journeySnapshot.data!.isNotEmpty) {
                          List<JourneyModel> journeys = journeySnapshot.data!;
                          return Container(
                            height: 200.0, // تعيين ارتفاع الحاوية
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: journeys.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 20.0),
                                  child: Center(
                                    child: Journeycard(
                                      Icons: true,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => JourneyShow(
                                                Id: journeys[index].id!),
                                          ),
                                        );
                                      },
                                      journey: journeys[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(child: Text('No data available'));
                        }
                      },
                    )),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, MyJourney.screenRoot);
            },
            child: Text(
              'My Journey',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.money_off_csred_outlined,
                color: Colors.green,
                size: 30,
              ),
              SizedBox(width: 10),
              Text('Your Currency is : 500', style: TextStyle(fontSize: 18)),
            ],
          ),
          actions: [
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
