import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/airline_show_model.dart';
import 'package:flutter_application_1/services/airline_show_service.dart';

class AirlinesShow extends StatelessWidget {
  final int id;
  final AirlineshowService airlineshow = AirlineshowService();

  AirlinesShow({super.key, required this.id});

  static String screenRoot = 'airline_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'asset/image/photo_2024-05-22_13-06-53.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: FutureBuilder<List<AirlineshowModel>>(
              future: airlineshow.fetchairlineshow(
                '3|aUsbARf3ghMYGf9MVm5WSG9oUAwXbQ36bsXlzwFu81e98c80',
                id,
              ), // تمرير id بشكل صحيح
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.isEmpty) {
                  return const Text('No data available');
                } else {
                  final airline = snapshot.data!.first;
                  return Container(
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Name: ${airline.name ?? 'N/A'}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Location: ${airline.location ?? 'N/A'}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Mobile: ${airline.mobile ?? 'N/A'}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Email: ${airline.email ?? 'N/A'}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
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
