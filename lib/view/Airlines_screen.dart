import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/airline_model.dart';
import 'package:flutter_application_1/services/airline_service.dart';
import 'package:flutter_application_1/view/airline_show_screen.dart';
import 'package:flutter_application_1/widget/airline_card.dart';

class AirlinesScreen extends StatelessWidget {
  final AllairlineService airlineservice = AllairlineService();

  AirlinesScreen({super.key});

  static String screenRoot = 'airline_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: FutureBuilder<List<AirlineModel>>(
              future: airlineservice.fetchairline(
                '1|WWoI8gaKPj6AgNiIgkHLYZT4UwgK3B24XN3vpBhp562649fb',
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  List<AirlineModel> airlines = snapshot.data!;
                  return ListView.builder(
                    itemCount: airlines.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20.0,
                        ),
                        child: Airlinecard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AirlinesShow(id: airlines[index].id!),
                              ),
                            );
                          },
                          airline: airlines[index],
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
    );
  }
}
