import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/journey_activites_required_model.dart';

class JourneyActivitesCardOP extends StatelessWidget {
  final ActiviyyRequiredModel activityoptional;

  const JourneyActivitesCardOP({super.key, required this.activityoptional});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
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
                  activityoptional.activity_name ?? 'fff',
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
                  '${activityoptional.price ?? 'N/A'}',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                SizedBox(width: 8),
                Icon(Icons.attach_money, color: Colors.grey),
                SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
