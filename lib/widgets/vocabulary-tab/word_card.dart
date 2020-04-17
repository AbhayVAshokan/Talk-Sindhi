// Card containing the word and its translation.

import 'dart:math';

import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final String word;
  final String language;

  WordCard({
    @required this.word,
    @required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double width = mediaQuery.size.width;
    final double height = mediaQuery.size.height - mediaQuery.padding.top;

    return SizedBox(
      width: width * 0.9,
      height: min(height * 0.3, 220),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.symmetric(vertical: 35.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 50.0,
                ),
                child: FittedBox(
                  child: Text(
                    word,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                    textDirection: language == 'english'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 30.0,
              ),
              child: const Text(
                '---------------------------------------------------------------------------------------------------------------------------',
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: language == 'english' ? 20 : constraints.maxWidth - 90,
              child: GestureDetector(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 35.0,
                  backgroundImage:
                      const AssetImage('assets/images/speaker.png'),
                  backgroundColor: const Color(0x00FFFFFF),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: language == 'english' ? 100 : constraints.maxWidth - 190,
              child: const Text(
                'Tap to listen',
                style: const TextStyle(
                  color: Colors.grey,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
