// TODO: Edit after obtaining data from JSON file

import 'package:flutter/foundation.dart';

class Topic {
  final String categoryId;
  final String name;
  final int totalWords;
  final String imageUrl;
  List<String> words;
  int learnedWords;

  Topic({
    @required this.categoryId,
    @required this.name,
    @required this.learnedWords,
    @required this.imageUrl,
    this.totalWords = 20,
    this.words,
  });
}

List vocabulary = [];
List conversation = [];
List sentence = [];

// Dummy Data
List<Topic> dummyTopics = [
  Topic(
    categoryId: '0',
    name: 'Animals',
    learnedWords: 10,
    imageUrl: 'assets/images/topics_screen/animal.png',
    words: [
      'Bear',
      'Bull',
      'Buffallo',
      'Bull',
      'Camel',
      'Cat',
      'Dog',
      'Cow',
      'Goat',
      'Sheep',
      'Monkey',
      'Donkey',
      'Sloth',
      'Pig',
      'Fox',
      'Tiger',
      'Lion',
      'Deer',
      'Panther',
      'Cheetah',
    ],
  ),
  Topic(    categoryId: '1',

    name: 'Birds',
    learnedWords: 10,
    imageUrl: 'assets/images/topics_screen/birds.png',
    words: [
      'Bear',
      'Bull',
      'Buffallo',
      'Bull',
      'Camel',
      'Cat',
      'Dog',
      'Cow',
      'Goat',
      'Sheep',
      'Monkey',
      'Donkey',
      'Sloth',
      'Pig',
      'Fox',
      'Tiger',
      'Lion',
      'Deer',
      'Panther',
      'Cheetah',
    ],
  ),
  Topic(    categoryId: '2',

    name: 'Colors',
    learnedWords: 10,
    imageUrl: 'assets/images/topics_screen/colors.png',
    words: [
      'Bear',
      'Bull',
      'Buffallo',
      'Bull',
      'Camel',
      'Cat',
      'Dog',
      'Cow',
      'Goat',
      'Sheep',
      'Monkey',
      'Donkey',
      'Sloth',
      'Pig',
      'Fox',
      'Tiger',
      'Lion',
      'Deer',
      'Panther',
      'Cheetah',
    ],
  ),
  Topic(    categoryId: '3',

    name: 'Creature',
    learnedWords: 10,
    imageUrl: 'assets/images/topics_screen/creature.png',
    words: [
      'Bear',
      'Bull',
      'Buffallo',
      'Bull',
      'Camel',
      'Cat',
      'Dog',
      'Cow',
      'Goat',
      'Sheep',
      'Monkey',
      'Donkey',
      'Sloth',
      'Pig',
      'Fox',
      'Tiger',
      'Lion',
      'Deer',
      'Panther',
      'Cheetah',
    ],
  ),
  Topic(    categoryId: '4',

    name: 'Dress',
    learnedWords: 10,
    imageUrl: 'assets/images/topics_screen/dress.png',
    words: [
      'Bear',
      'Bull',
      'Buffallo',
      'Bull',
      'Camel',
      'Cat',
      'Dog',
      'Cow',
      'Goat',
      'Sheep',
      'Monkey',
      'Donkey',
      'Sloth',
      'Pig',
      'Fox',
      'Tiger',
      'Lion',
      'Deer',
      'Panther',
      'Cheetah',
    ],
  ),
  Topic(    categoryId: '5',

    name: 'Education',
    learnedWords: 10,
    imageUrl: 'assets/images/topics_screen/education.png',
    words: [
      'Bear',
      'Bull',
      'Buffallo',
      'Bull',
      'Camel',
      'Cat',
      'Dog',
      'Cow',
      'Goat',
      'Sheep',
      'Monkey',
      'Donkey',
      'Sloth',
      'Pig',
      'Fox',
      'Tiger',
      'Lion',
      'Deer',
      'Panther',
      'Cheetah',
    ],
  ),
  Topic(    categoryId: '6',

    name: 'Fruits',
    learnedWords: 10,
    imageUrl: 'assets/images/topics_screen/fruits.png',
    words: [
      'Bear',
      'Bull',
      'Buffallo',
      'Bull',
      'Camel',
      'Cat',
      'Dog',
      'Cow',
      'Goat',
      'Sheep',
      'Monkey',
      'Donkey',
      'Sloth',
      'Pig',
      'Fox',
      'Tiger',
      'Lion',
      'Deer',
      'Panther',
      'Cheetah',
    ],
  ),
  Topic(    categoryId: '7',

    name: 'Health',
    learnedWords: 10,
    imageUrl: 'assets/images/topics_screen/health.png',
    words: [
      'Bear',
      'Bull',
      'Buffallo',
      'Bull',
      'Camel',
      'Cat',
      'Dog',
      'Cow',
      'Goat',
      'Sheep',
      'Monkey',
      'Donkey',
      'Sloth',
      'Pig',
      'Fox',
      'Tiger',
      'Lion',
      'Deer',
      'Panther',
      'Cheetah',
    ],
  ),
  Topic(    categoryId: '8',

    name: 'Nature',
    learnedWords: 10,
    imageUrl: 'assets/images/topics_screen/nature.png',
    words: [
      'Bear',
      'Bull',
      'Buffallo',
      'Bull',
      'Camel',
      'Cat',
      'Dog',
      'Cow',
      'Goat',
      'Sheep',
      'Monkey',
      'Donkey',
      'Sloth',
      'Pig',
      'Fox',
      'Tiger',
      'Lion',
      'Deer',
      'Panther',
      'Cheetah',
    ],
  ),
];
