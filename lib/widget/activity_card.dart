import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/activityModel.dart';

class Activitycard extends StatelessWidget {
  Activitycard({required this.onTap, required this.activity});

  final Function()? onTap;
  final Activities activity;

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
                  image: NetworkImage(activity.image ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 20, top: 140),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // يمكنك إضافة كود المفضلة هنا إذا كنت تريد.
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      activity.name ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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
