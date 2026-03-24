import 'package:flutter/material.dart';

import '../models/browse_resservation_model.dart';

class reservationcard extends StatelessWidget {
  const reservationcard({required this.onTap, required this.resserve});
  final Function()? onTap;
  final ResserationModel resserve;

  static String id = 'reservation';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 200,
        child: Card(
          color: Colors.white.withOpacity(0.8),
          margin: EdgeInsets.all(10),
          elevation: 10,
          shadowColor: Color(0xff4fc2f7),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Journey name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Text(
                        resserve.journeyName ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, HomePage.screenRoot);
                        },
                        icon: Icon(Icons.edit, color: Colors.blueGrey),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete, color: Color(0xff60080d)),
                      ),
                    ],
                  ),
                  SizedBox(height: 1),
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Icon(Icons.attach_money, color: Color(0xff4fc2f7)),
                      SizedBox(width: 10),
                      Text('Total price:'),
                      Text(resserve.totalPrice ?? ''),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Icon(Icons.hourglass_bottom, color: Color(0xff4fc2f7)),
                      SizedBox(width: 10),
                      Text('state:'),
                      Text(resserve.state ?? ''),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 15),
                      Icon(Icons.price_check, color: Color(0xff4fc2f7)),
                      SizedBox(width: 10),
                      Text('payment state: '),
                      Text(resserve.paymentState ?? ''),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
