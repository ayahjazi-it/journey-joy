import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/activityModel.dart';
import 'package:flutter_application_1/services/activity_service.dart';
import 'package:flutter_application_1/view/activity_show_screen.dart';
import 'package:flutter_application_1/widget/activity_card.dart';

class ActivityListScreen extends StatelessWidget {
  final AllactivityService activityService = AllactivityService();
  static String screenRoot = 'activity_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity List')),
      body: FutureBuilder<List<Activities>>(
        future: activityService.fetchActivities(
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
            List<Activities> activities = snapshot.data!;
            return ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Activitycard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ActivityShow(id: activities[index].id!),
                        ),
                      );
                    },
                    activity: activities[index],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
