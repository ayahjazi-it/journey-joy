import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/country_model.dart';

class Countrycard extends StatelessWidget {
  Countrycard({required this.onTap, required this.country});
  Function()? onTap;
  CountryModel country;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap!,
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
                  image: NetworkImage(country.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 20, top: 140),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        // يمكنك إضافة كود المفضلة هنا إذا كنت تريد.
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 60),
                    Text(
                      country.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        // backgroundColor: Colors.black87,
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
