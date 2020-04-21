import 'package:flutter/material.dart';
import 'package:talksindhi/file_operations.dart';

import '../../realtime_data.dart';

class PointsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    int points = userData['points'];

    int upperLimit, lowerLimit;
    if (points < 100) {
      lowerLimit = points;
      upperLimit = 100;
      userData['league'] = 'bronze';
    } else if (points < 250) {
      lowerLimit = points - 100;
      upperLimit = 250;
      userData['league'] = 'silver';
    } else if (points < 500) {
      lowerLimit = points - 350;
      upperLimit = 500;
      userData['league'] = 'gold';
    } else {
      lowerLimit = points;
      upperLimit = points;
      userData['league'] = 'gold';
    }

    writeToFile(content: userData, fileName: '/userData.json');

    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          bottomLeft: Radius.circular(50.0),
        ),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 2.0,
      ),
      color: Color(0xFF020021),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 10.0,
              bottom: 10.0,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: userData['league'] == 'bronze'
                      ? Color(0xFFCD6B32)
                      : (userData['league'] == 'silver'
                          ? Color(0xFFAAA9AD)
                          : Color(0xFFFFD700)),
                  radius: mediaQuery.size.width * 0.04,
                  child: FittedBox(
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  child: LinearProgressIndicator(
                    value: lowerLimit / upperLimit,
                    backgroundColor: Colors.white,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal),
                  ),
                ),
                const SizedBox.shrink(),
              ],
            ),
          ),
          Positioned(
            top: 5.0,
            left: 45.0,
            child: RichText(
              text: TextSpan(
                text: '$lowerLimit',
                children: [
                  TextSpan(
                    text: '/$upperLimit ',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: globalLanguage == 'english' ? 'points' : 'अंक',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.75,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
