import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/journey_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Journeycard extends StatefulWidget {
  final Function()? onTap;
  final JourneyModel journey;
  final Function(String journeyId)? onFavoriteRemoved;
  final bool Icons;
  Journeycard({
    required this.onTap,
    required this.journey,
    this.onFavoriteRemoved,
    required this.Icons,
  });

  @override
  _JourneyCardState createState() => _JourneyCardState();
}

class _JourneyCardState extends State<Journeycard> {
  bool isFavorite = false; // حالة لتتبع ما إذا كانت الرحلة في المفضلة أم لا
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    checkIfFavorite(
      widget.journey.id.toString(),
    ); // تحقق من حالة المفضلة عند تحميل الواجهة
  }

  Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: 250,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(widget.journey.image ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 100),
                  child: Row(
                    children: [
                      Icons == true
                          ? IconButton(
                              onPressed: () {
                                toggleFavorite(widget.journey.id.toString());
                              },

                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                                size: 30,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                toggleFavorite(widget.journey.id.toString());
                              },

                              icon: Icon(
                                Icons.delete,
                                color: isFavorite ? Colors.red : Colors.grey,
                                size: 30,
                              ),
                            ),

                      SizedBox(width: 20),
                      Text(
                        widget.journey.name ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkIfFavorite(String journeyId) async {
    try {
      final String? token = sharedPreferences.getString('token');
      if (token == null) throw Exception('Token not found');

      final response = await http.get(
        Uri.parse('http://192.168.43.142:8000/api/favorites/$journeyId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          isFavorite =
              data['is_favorite']; // تحديث حالة المفضلة بناءً على الاستجابة
        });
      } else {
        print('Error checking favorite status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void toggleFavorite(String journeyId) async {
    final String? token = sharedPreferences.getString('token');
    if (token == null) throw Exception('Token not found');

    if (isFavorite) {
      // إزالة من المفضلة
      try {
        final response = await http.delete(
          Uri.parse(
            'http://192.168.43.142:8000/api/favorites/remove?journey_id=$journeyId',
          ),
          headers: {'Authorization': 'Bearer $token'},
        );
        if (response.statusCode == 200) {
          setState(() {
            isFavorite = false;
          });
          widget.onFavoriteRemoved?.call(
            journeyId,
          );
          print('Journey removed from favorites successfully');
        } else {
          print('Error removing from favorites: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      // إضافة إلى المفضلة
      try {
        final response = await http.post(
          Uri.parse('http://$localhost:8000/api/favorites'),
          headers: {'Authorization': 'Bearer $token'},
          body: {'journey_id': journeyId},
        );
        if (response.statusCode == 200) {
          setState(() {
            isFavorite = true; // عكس حالة المفضلة عند النجاح
          });
          print('Journey added to favorites successfully');
        } else if (response.statusCode == 409) {
          print(response.body);
        } else {
          print('Error adding to favorites: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}
