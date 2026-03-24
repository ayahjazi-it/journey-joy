import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/cash_helper.dart';
import 'package:flutter_application_1/models/journey_activites_required_model.dart';
import 'package:flutter_application_1/models/journey_show_model.dart';
import 'package:flutter_application_1/services/activity_service.dart';
import 'package:flutter_application_1/services/journey_activites_optional.dart';
import 'package:flutter_application_1/services/journey_activites_required.dart';
import 'package:flutter_application_1/services/journey_show_service.dart';
import 'package:flutter_application_1/widget/drowp_down.dart';
import 'package:flutter_application_1/widget/journey_activites_optional_card.dart';
import 'package:flutter_application_1/widget/journey_activites_required_card.dart';
import 'package:http/http.dart' as http;


class JourneyShow extends StatefulWidget {
  final int Id;

  JourneyShow({
    super.key,
    required this.Id,
  });

  static String screenRoot = 'journeyshow_screen';

  @override
  State<JourneyShow> createState() => _JourneyShowState();
}

class _JourneyShowState extends State<JourneyShow> {
  final AllactivityService activityService = AllactivityService();
  final AllActivityRequired allactivitesrequired = AllActivityRequired();
  final AllActivityoptional allactivitesoptional = AllActivityoptional();
  AlljourneyshowService alljourneyshow = AlljourneyshowService();

  final numberSets = TextEditingController();
  String? token = CashHelper.getUserToken();
  late List<ActiviyyRequiredModel> selectedActivities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<JourneyShowModel>>(
        future: alljourneyshow.fetchshowhotel(
          '80|q62Nh17aUhJIBf4qvqKoBgiWc0tHNuH0dSb62Y3c647e11f0',
          widget.Id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<JourneyShowModel> journeys = snapshot.data!;
            return ListView.builder(
              itemCount: journeys.length,
              itemBuilder: (context, index) {
                JourneyShowModel journey = journeys[index];
                return Column(
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(journey.image ??
                              'asset/image/photo_2024-03-24_16-15-42.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        journey.name ?? 'No name',
                        style: TextStyle(
                          color: Color(0xff44bcd8),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Column(
                        children: [
                          Text('الوصف'),
                          Text(journey.description ?? 'No description'),
                        ],
                      ),
                    ),
                    SizedBox(height: 80),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'startPlace',
                                style: TextStyle(
                                  color: Color(0xff44bcd8),
                                ),
                              ),
                              Text('${journey.destinationRegionId ?? 0}'),
                            ],
                          ),
                          SizedBox(width: 25),
                          Icon(Icons.airport_shuttle, color: Color(0xffe07b39)),
                          SizedBox(width: 25),
                          Column(
                            children: [
                              Text(
                                'destination',
                                style: TextStyle(
                                  color: Color(0xff44bcd8),
                                ),
                              ),
                              Text('${journey.startPlaceRegionId ?? 'N/A'}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Start Date',
                                style: TextStyle(
                                  color: Color(0xff44bcd8),
                                ),
                              ),
                              Text(journey.startDate ?? 'N/A'),
                            ],
                          ),
                          SizedBox(width: 25),
                          Icon(Icons.calendar_month, color: Color(0xffe07b39)),
                          SizedBox(width: 25),
                          Column(
                            children: [
                              Text(
                                'End Date',
                                style: TextStyle(
                                  color: Color(0xff44bcd8),
                                ),
                              ),
                              Text(journey.endDate ?? 'N/A'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    Center(
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xff44bcd8), width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('The Capacity'),
                            SizedBox(width: 6),
                            Text('${journey.userId ?? 'N/A'}'),
                            SizedBox(width: 7),
                            Icon(Icons.person, color: Color(0xff44bcd8)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xff44bcd8), width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Text('Cost: ${journey.journeyPrice ?? 'N/A'}'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 200),
                      child: Text(
                        'Journey Activities',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    FutureBuilder<List<ActiviyyRequiredModel>>(
                      future: allactivitesrequired.fetchactivityrequired(
                        '80|q62Nh17aUhJIBf4qvqKoBgiWc0tHNuH0dSb62Y3c647e11f0',
                        widget.Id,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No data available'));
                        } else {
                          List<ActiviyyRequiredModel> activitesrequired =
                              snapshot.data!;
                          return Container(
                            height: 200,
                            child: ListView.builder(
                              itemCount: activitesrequired.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: JourneyActivitesCard(
                                      activity: activitesrequired[index]),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 200),
                      child: Text(
                        'Optional Activites',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    FutureBuilder<List<ActiviyyRequiredModel>>(
                      future: allactivitesoptional.fetchactivityoptional(
                        '80|q62Nh17aUhJIBf4qvqKoBgiWc0tHNuH0dSb62Y3c647e11f0',
                        widget.Id,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No data available'));
                        } else {
                          List<ActiviyyRequiredModel> activitesOP =
                              snapshot.data!;
                          return Container(
                            height: 200,
                            child: ListView.builder(
                              itemCount: activitesOP.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: JourneyActivitesCardOP(
                                      activityoptional: activitesOP[index]),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                    Container(
                      height: 200.0,
                      child: FutureBuilder<List<ActiviyyRequiredModel>>(
                        future: allactivitesoptional.fetchactivityoptional(
                          '80|q62Nh17aUhJIBf4qvqKoBgiWc0tHNuH0dSb62Y3c647e11f0',
                          widget.Id,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return Center(child: Text('No data available'));
                          } else {
                            List<ActiviyyRequiredModel> activities =
                                snapshot.data!;
                            List<String> dates = activities
                                .map((activity) => activity.date ?? 'Unknown')
                                .toSet()
                                .toList();

                            return MultiSelectDropdown(
                              fetchActivities:
                                  AllActivityoptional().fetchactivityoptional,
                              token: '$token',
                              journeyId: widget.Id,
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 90, right: 90, bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ReservationsGuestPage(id: widget.Id),
                          //   ),
                          // );
                        },
                        child: Container(
                          height: 60,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Color(0xffe07b39),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Join The Journey',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 40,
            ),
            SizedBox(width: 10),
            Text('Modified successfully', style: TextStyle(fontSize: 18)),
          ],
        ),
        actions: [
          TextButton(
            child: Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
