// Apps in ListView

import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import './app_card.dart';
import '../../custom_icons.dart';

class OtherApps extends StatelessWidget {
  final String language;
  OtherApps({@required this.language});

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
            Row(
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
                    language == 'english'
                        ? "Sindhi Sangat Apps"
                        : 'सिंधी संगत एप्स',
                    style: TextStyle(
                      fontSize: constraints.maxHeight * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await launch('https://www.sindhisangat.com/');
                      },
                      child: Icon(
                        Icons.language,
                        color: Colors.black,
                        size: 27.0,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () async {
                        await launch(
                            'https://www.facebook.com/SindhiSangatWorldwide/');
                      },
                      child: Icon(
                        CustomIcons.facebook_squared,
                        color: Colors.blue,
                        size: 27.0,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () async {
                        await launch('https://twitter.com/sindhisangat');
                      },
                      child: Icon(
                        CustomIcons.twitter_squared,
                        color: Colors.lightBlue,
                        size: 27.0,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () async {
                        await launch(
                            'https://www.youtube.com/channel/UCUYUVlCYTLnnQ3X5Ghj3Ojw');
                      },
                      child: Icon(
                        CustomIcons.youtube_play,
                        color: Colors.red,
                        size: 27.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: width,
              height: constraints.maxHeight * 0.8,
              padding: const EdgeInsets.only(left: 10.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  AppCard(
                    imageUrl: 'assets/images/home_screen/learn_sindhi_logo.png',
                    title: 'Learn Sindhi',
                    width: constraints.maxHeight * 0.75,
                    subtitle: 'Available on',
                    onTap: () => Share.share(
                      'https://play.google.com/store/apps/details?id=com.sindhisangat.learnsindhi \n\nSindhi Sangat has produced a very simple to use Sindhi Learning App " Learn Sindhi" . The Learn Sindhi app is available on Android devices as well as iOS devices. The Learn Sindhi app contains animations, voice, games which make it fun to Learn and practice basics of the Sindhi language. The app also encourages users to register and they can be part of the Sindhi language community.',
                    ),
                  ),
                  AppCard(
                    imageUrl: 'assets/images/home_screen/speak_sindhi_logo.png',
                    title: 'Speak Sindhi',
                    subtitle:
                        language == 'english' ? 'Coming soon' : 'जल्द आ रहा है',
                    width: constraints.maxHeight * 0.75,
                  ),
                  AppCard(
                    imageUrl:
                        'assets/images/home_screen/idioms_and_proverbs_logo.png',
                    title: 'Idioms & Proverbs',
                    subtitle:
                        language == 'english' ? 'Coming soon' : 'जल्द आ रहा है',
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
