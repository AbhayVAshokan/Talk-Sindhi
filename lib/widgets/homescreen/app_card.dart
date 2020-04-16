import 'dart:math';

import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double width;
  final Function onTap;

  AppCard({
    @required this.imageUrl,
    @required this.title,
    this.subtitle = "Available on",
    this.width = 175,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.subtitle == "Available on" ? () => onTap() : () {},
      child: Padding(
        padding: const EdgeInsets.only(
          right: 10.0,
          top: 10.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Container(
            width: width < 175 ? width : 175,
            margin: const EdgeInsets.only(bottom: 6.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).backgroundColor,
                  Colors.blue[300],
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height:
                        min(constraints.maxWidth, constraints.maxHeight) * 0.65,
                    width:
                        min(constraints.maxWidth, constraints.maxHeight) * 0.65,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(imageUrl), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Column(
                    children: [
                      FittedBox(
                        child: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontSize: constraints.maxHeight * 0.11),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FittedBox(
                            child: Text(
                              subtitle,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: constraints.maxHeight * 0.09,
                              ),
                            ),
                          ),
                          this.subtitle == "Available on"
                              ? Row(
                                  children: [
                                    const SizedBox(width: 10.0),
                                    Image.asset(
                                      'assets/images/home_screen/play_store_logo.png',
                                      width: 12.0,
                                      height: 12.0,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Image.asset(
                                      'assets/images/home_screen/app_store_logo.png',
                                      width: 12.0,
                                      height: 12.0,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
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
