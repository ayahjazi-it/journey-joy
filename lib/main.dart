import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/cash_helper.dart';
import 'package:flutter_application_1/locale/locale.dart';
import 'package:flutter_application_1/locale/locale_controllar.dart';
import 'package:flutter_application_1/povider/mode_provider.dart';
import 'package:flutter_application_1/them_mode.dart';
import 'package:flutter_application_1/view/Airlines_screen.dart';
import 'package:flutter_application_1/view/activity_screen.dart';
import 'package:flutter_application_1/view/codescreen.dart';
import 'package:flutter_application_1/view/comment_screen.dart';
import 'package:flutter_application_1/view/details_trip.dart';
import 'package:flutter_application_1/view/editprofile_screen.dart';
import 'package:flutter_application_1/view/favorite.dart';
import 'package:flutter_application_1/view/home_page.dart';
import 'package:flutter_application_1/view/hotel_list_screen.dart';
import 'package:flutter_application_1/view/map.dart';
import 'package:flutter_application_1/view/myjourney_screen.dart';
import 'package:flutter_application_1/view/outh/register_screen.dart';
import 'package:flutter_application_1/view/outh/signin_screen.dart';
import 'package:flutter_application_1/view/outh/splash_screen.dart';
import 'package:flutter_application_1/view/restaurant_list_screen.dart';
import 'package:flutter_application_1/view/search_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(Mylocalecontrollar());
  await CashHelper().init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ModeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return Consumer<ModeProvider>(
      builder: (context, modeProvider, child) {

        var id;
        return GetMaterialApp(
          theme: modeProvider.lightModeEnable
              ? ModeThem.lightmode
              : ModeThem.darkTheme,
          locale: Get.deviceLocale,
          translations: Mylocale(),
          debugShowCheckedModeBanner: false,
          initialRoute: Splashscreen.screenRoot,
          routes: {
            Splashscreen.screenRoot: (context) => Splashscreen(),
            SigninScreen.screenRoot: (context) => SigninScreen(),
            Registerscreen.screenRoot: (context) => Registerscreen(),
            homePage.screenRoot: (context) => homePage(favorittrip: []),
            detailsTrip.screenRoot: (context) => detailsTrip(),
            Codescreen.screenRoot: (context) => Codescreen(),
            MapHome.screenRoot: (context) => MapHome(),
            JourneySearchScreen.screenRoot: (context) => JourneySearchScreen(),
            FavoritesPage.screenRoot: (context) => FavoritesPage(),
            RestaurantListScreen.screenRoot: (context) =>
                RestaurantListScreen(),
            Editprofile.screenRoot: (context) => Editprofile(),
            HotelListScreen.screenRoot: (context) => HotelListScreen(),
            ActivityListScreen.screenRoot: (context) => ActivityListScreen(),
            CommentScreen.screenRoot : (context) => CommentScreen(),
            AirlinesScreen.screenRoot :  (context) =>  AirlinesScreen(),
            MyJourney.screenRoot :  (context) => MyJourney(),
            // JourneyShow.screenRoot : (context) => JourneyShow(Id: 1),
          },
        );
      },
    );
  }
}
