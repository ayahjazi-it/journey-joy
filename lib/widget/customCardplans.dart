import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/plansModel.dart';
import 'package:flutter_application_1/view/details_trip.dart';

class customCardPlan extends StatelessWidget {
  customCardPlan({super.key, required this.plan});

  tripModel plan;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, detailsTrip.screenRoot);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.only(bottom: 15),
              width: 200,
              color: Colors.grey[200],
              child: Image.network(plan.image, height: 120, fit: BoxFit.cover),
            ),
            Text(
              plan.title.substring(0, 6),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.today, color: Colors.black, size: 20),
                SizedBox(width: 3),
                Text(
                  "20 april",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 80),
                Text(
                  r'$'
                  '${plan.price.toString()}',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
