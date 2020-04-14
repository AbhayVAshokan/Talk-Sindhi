import 'package:flutter/foundation.dart';

class Vocabulary {
  final String category;
  final int totalWords;
  final int learnedWords;

  Vocabulary({
    @required this.category,
    @required this.totalWords,
    @required this.learnedWords,
  });
}
