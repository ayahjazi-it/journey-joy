import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/journey_activites_required_model.dart';

class JourneyActivitesCard extends StatelessWidget {
  final ActiviyyRequiredModel activity;

  const JourneyActivitesCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  activity.activity_name ?? '',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                SizedBox(width: 8),
                Icon(Icons.directions_walk, color: Colors.grey),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  activity.date ?? '',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                SizedBox(width: 8),
                Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 8),
                Icon(Icons.attach_money, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  '${activity.price ?? 'N/A'}',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
