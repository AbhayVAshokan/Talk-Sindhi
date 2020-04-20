// Card containing the word and its translation.

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class WordCard extends StatelessWidget {
  final String word;
  final String language;
  final String media;

  WordCard({
    @required this.word,
    @required this.language,
    this.media,
  });

  final AudioPlayer audioPlayer = AudioPlayer();

  // Play offline audio if available, else play online audio and download the audio for offline play.
  playLocalAudio(localPath) async {
    await audioPlayer.play(localPath, isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double width = mediaQuery.size.width;
    final double height = mediaQuery.size.height - mediaQuery.padding.top;

    String directoryPath;
    getApplicationDocumentsDirectory().then(
      (Directory dir) => directoryPath = dir.path,
    );

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
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: word.length < 10 ? 20.0 : 60.0,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    word,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: language == 'sindhi' ? 100.0 : 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                    textDirection: language == 'english' || language == 'hindi'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: language == 'sindhi' ? 50.0 : 40,
                bottom: 0.0,
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
              left: language == 'english' || language == 'hindi'
                  ? 20
                  : constraints.maxWidth - 90,
              child: GestureDetector(
                onTap: () {
                  if (media == null) {
                    Fluttertoast.showToast(
                      msg: "Audio not available",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    playLocalAudio('$directoryPath/$word.mp3');
                  }
                },
                child: CircleAvatar(
                  radius: 35.0,
                  foregroundColor: Colors.white,
                  backgroundImage: AssetImage(
                    (language == 'sindhi' && media != null)
                        ? 'assets/images/speaker_on.png'
                        : (language == 'sindhi'
                            ? 'assets/images/sound_off.png'
                            : 'assets/images/book.png'),
                  ),
                  backgroundColor: const Color(0x00FFFFFF),
                ),
              ),
            ),
            (language == 'sindhi' && media != null)
                ? Positioned(
                    top: 50,
                    left: constraints.maxWidth - 190,
                    child: const Text(
                      'Tap to listen',
                      style: const TextStyle(
                        color: Colors.grey,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
