import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/plansModel.dart';

class detailsTrip extends StatefulWidget {
  static String screenRoot = 'details_screen';
  @override
  State<detailsTrip> createState() => _detailsTripState();
}

class _detailsTripState extends State<detailsTrip> {
  bool swimm = false;
  bool shopp = false;
  bool horse = false;
  bool Accommodation = false;
  dynamic prric = 100;

  // final String? title;
  @override
  Widget build(BuildContext context) {
    tripModel routargument =
        ModalRoute.of(context)!.settings.arguments as tripModel;

    final tripid = routargument.id;
    final triptitle = routargument.title;
    final tripimage = routargument.image;
    dynamic triprice = routargument.price;
    // prric = triprice;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          triptitle.substring(0, 7),
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            Image.network(
              tripimage,
              fit: BoxFit.cover,
              cacheHeight: 200,
              cacheWidth: 350,
            ),
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.only(
                left: 14,
                right: 10,
                top: 10,
                bottom: 15,
              ),
              margin: EdgeInsets.only(top: 20, bottom: 25),
              child: Text(
                style: TextStyle(fontSize: 16),
                "A trip to Bloudan will start from Mezzeh.Activities such as swimming, shopping, and horse riding will be carried out,and staying at the Najma Hotel.",
              ),
            ),
            Text(
              r'   Trip cost : $'
              '${prric}',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 10),
            Text(
              "  Cancel activities you don't want :",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
            CheckboxListTile(
              activeColor: Color.fromARGB(255, 44, 240, 51),
              checkColor: Colors.black,
              tileColor: Colors.grey[300],
              title: Text(
                "swimming",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              value: swimm,
              onChanged: (value) {
                setState(() {
                  swimm = value!;
                  if (swimm == true) {
                    prric = prric + 10;
                  } else
                    prric = prric - 10;
                });
              },
            ),
            CheckboxListTile(
              activeColor: Color.fromARGB(255, 44, 240, 51),
              checkColor: Colors.black,
              tileColor: Colors.grey[300],
              title: Text(
                "shopping",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              value: shopp,
              onChanged: (value) {
                setState(() {
                  shopp = value!;
                  if (shopp == true) {
                    prric = prric + 20;
                  } else
                    prric = prric - 20;
                });
              },
            ),
            CheckboxListTile(
              activeColor: Color.fromARGB(255, 44, 240, 51),
              checkColor: Colors.black,
              tileColor: Colors.grey[300],
              title: Text(
                "horse riding",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              value: horse,
              onChanged: (value) {
                setState(() {
                  horse = value!;
                  if (horse == true) {
                    prric = prric + 10;
                  } else
                    prric = prric - 10;
                });
              },
            ),
            SizedBox(height: 15),
            Text(
              "  Hotel accommodation:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.red,
              ),
            ),
            CheckboxListTile(
              activeColor: Color.fromARGB(255, 44, 240, 51),
              checkColor: Colors.black,
              tileColor: Colors.grey[300],
              title: Text(
                "with/without Accommodation",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              value: Accommodation,
              onChanged: (value) {
                setState(() {
                  Accommodation = value!;
                  if (Accommodation == true) {
                    prric = prric + 40;
                  } else
                    prric = prric - 40;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
