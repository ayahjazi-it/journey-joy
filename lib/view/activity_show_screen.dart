import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/activity_show_model.dart';
import 'package:flutter_application_1/services/activity_show_service.dart';

class ActivityShow extends StatelessWidget {
  final ActivityShowService allshowactivity = ActivityShowService();
  final int id;

  ActivityShow({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity Details')),
      body: FutureBuilder<List<ActivityShowModel>>(
        future: allshowactivity.fetchshowactivity(
          '1|WWoI8gaKPj6AgNiIgkHLYZT4UwgK3B24XN3vpBhp562649fb',
          id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<ActivityShowModel> activities = snapshot.data!;
            return ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                ActivityShowModel activity = activities[index];
                return Column(
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(activity.image ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 90,
                        left: 90,
                      ),
                      child: Text(
                        activity.name ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 20,
                        left: 8,
                      ),
                      child: Text(
                        activity.details ?? '',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
