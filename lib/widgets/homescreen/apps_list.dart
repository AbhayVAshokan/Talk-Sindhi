// Apps in ListView

import 'package:flutter/material.dart';
import 'package:share/share.dart';

import './app_card.dart';

class AppsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 10.0,
                  ),
                ),
              ),
              child: Text(
                "Sindhi Sangat Apps",
                style: TextStyle(
                  fontSize: constraints.maxHeight * 0.1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: width,
              height: constraints.maxHeight * 0.88,
              padding: const EdgeInsets.only(left: 10.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  AppCard(
                    imageUrl: 'assets/images/learn_sindhi_logo.png',
                    title: 'Learn Sindhi',
                    width: constraints.maxHeight * 0.75,
                    onTap: () => Share.share(
                      'https://play.google.com/store/apps/details?id=com.sindhisangat.learnsindhi \n\nSindhi Sangat has produced a very simple to use Sindhi Learning App " Learn Sindhi" . The Learn Sindhi app is available on Android devices as well as iOS devices. The Learn Sindhi app contains animations, voice, games which make it fun to Learn and practice basics of the Sindhi language. The app also encourages users to register and they can be part of the Sindhi language community.',
                    ),
                  ),
                  AppCard(
                    imageUrl: 'assets/images/speak_sindhi_logo.png',
                    title: 'Speak Sindhi',
                    subtitle: 'Coming soon',
                    width: constraints.maxHeight * 0.75,
                  ),
                  AppCard(
                    imageUrl: 'assets/images/idioms_and_proverbs_logo.png',
                    title: 'Idioms & Proverbs',
                    subtitle: 'Coming soon',
                    width: constraints.maxHeight * 0.75,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
