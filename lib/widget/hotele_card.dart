import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/hotel_model.dart';

class Hotelscard extends StatelessWidget {
  final Function()? onTap;
  final Hotels hotel;

  Hotelscard({required this.onTap, required this.hotel});

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
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(hotel.image ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 20, top: 140),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {},
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 30),
                    Text(
                      hotel.name ?? 'No name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
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
    );
  }
}
