import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../my_bottom_navbar.dart';
import '../widgets/homescreen/other_apps.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height - mediaQuery.padding.top;
    final width = mediaQuery.size.width;
    final screenRatio = height / width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(
          context: context,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Container(
                width: width,
                padding: const EdgeInsets.only(left: 150, top: 10),
                child: Image.asset(
                  'assets/images/home_screen/ic_landing_image.png',
                  alignment: Alignment.centerRight,
                  fit: BoxFit.contain,
                  width: screenRatio >= 1 ? width / 2 : height / 2,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 5.0,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Welcome to Sindhi Sangat\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: constraints.maxHeight * 0.18,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Made Easy",
                              style: TextStyle(
                                fontSize: constraints.maxHeight * 0.15,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox.shrink(),
                      Text(
                        "Dedicated to the promotion of Sindhi Language Culture & Heritage",
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.grey,
                              fontSize: constraints.maxHeight * 0.12,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: OtherApps(),
            ),
          ],
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          currentIndex: 0,
        ),
      ),
    );
  }
}
