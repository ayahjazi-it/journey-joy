import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/airline_model.dart';
import 'package:http/http.dart' as http;

class Airlinecard extends StatelessWidget {
  Airlinecard({required this.onTap, required this.airline});

  final Function()? onTap;
  final AirlineModel airline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    airline.name ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
