import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/journey_model.dart';
import 'package:flutter_application_1/services/favourite_service.dart';
import 'package:flutter_application_1/widget/journey_card.dart';

class FavoritesPage extends StatefulWidget {
  static String screenRoot = 'favorite_screen';

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<JourneyModel>> _favoriteJourneys;

  @override
  void initState() {
    super.initState();
    _loadFavoriteJourneys(); // جلب الرحلات المفضلة
  }

  void _loadFavoriteJourneys() {
    setState(() {
      _favoriteJourneys = FavouriteService().fetchFavourite();
    });
  }

  void _removeJourneyFromFavorites(String journeyId) {
    setState(() {
      _favoriteJourneys = _favoriteJourneys.then(
        (journeys) =>
            journeys.where((journey) => journey.id != journeyId).toList(),
      );
    });
  }

  void _addJourneyToFavorites(JourneyModel journey) {
    setState(() {
      _favoriteJourneys = _favoriteJourneys.then((journeys) {
        journeys.add(journey);
        return journeys;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text('Favorites')),
      body: FutureBuilder<List<JourneyModel>>(
        future: _favoriteJourneys,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorites found'));
          } else {
            List<JourneyModel> journeys = snapshot.data!;
            return Center(
              child: SizedBox(
                width:
                    MediaQuery.of(context).size.width *
                    0.9, // تحديد عرض ListView
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: journeys.length,
                  itemBuilder: (context, index) {
                    return Journeycard(
                      Icons: false,
                      journey: journeys[index],
                      onTap: () {
                        //Journeycard.toggleFavorite();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => JourneyShow(Id: journeys[index].id!),
                        //   ),
                        // );
                      },
                      onFavoriteRemoved:
                          _removeJourneyFromFavorites, // استدعاء عند إزالة رحلة من المفضلة
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
  // void toggleFavorite(String journeyId) async {
  //   final String? token = CashHelper.getUserToken();
  //   if (token == null) throw Exception('Token not found');
  //
  //   if (isFavorite) {
  //     // إزالة من المفضلة
  //     try {
  //       final response = await http.delete(
  //         Uri.parse('http://192.168.43.142:8000/api/favorites/remove?journey_id=$journeyId'),
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       );
  //       if (response.statusCode == 200) {
  //         setState(() {
  //           isFavorite = false; // عكس حالة المفضلة عند النجاح
  //         });
  //         widget.onFavoriteRemoved?.call(journeyId); // إبلاغ واجهة المفضلة بإزالة الرحلة
  //         print('Journey removed from favorites successfully');
  //       } else {
  //         print('Error removing from favorites: ${response.statusCode}');
  //       }
  //     } catch (e) {
  //       print('Error: $e');
  //     }
  //   } else {
  //     // إضافة إلى المفضلة
  //     try {
  //       final response = await http.post(
  //         Uri.parse('http://192.168.43.142:8000/api/favorites'),
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //         body: {
  //           'journey_id': journeyId,
  //         },
  //       );
  //       if (response.statusCode == 200) {
  //         setState(() {
  //           isFavorite = true; // عكس حالة المفضلة عند النجاح
  //         });
  //         print('Journey added to favorites successfully');
  //       } else if (response.statusCode == 409) {
  //         print(response.body);
  //       } else {
  //         print('Error adding to favorites: ${response.statusCode}');
  //       }
  //     } catch (e) {
  //       print('Error: $e');
  //     }
  //   }
  // }
}
