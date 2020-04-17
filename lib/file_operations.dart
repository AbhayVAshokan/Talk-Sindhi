import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:talksindhi/models/topic.dart';
import 'package:path_provider/path_provider.dart';

// Create the local JSON file
void createFile({
  @required Map<String, dynamic> content,
  @required String pathToJSON,
}) {
  File file = File(pathToJSON);
  file.createSync();
  file.writeAsStringSync(jsonEncode(content));
}

// Write content into local JSON file
void writeToFile({
  @required Map<String, dynamic> content,
  @required String fileName,
}) {
  Directory directory;

  // Function to return the location at which the data is stored locally.
  getApplicationDocumentsDirectory().then(
    (Directory dir) {
      directory = dir;
      var path = directory.path + '/' + fileName;
      var jsonFile = File(path);

      bool fileExists = jsonFile.existsSync();
      if (fileExists) {
        var readFile = jsonFile.readAsStringSync();
        Map<String, dynamic> jsonFileContents = json.decode(readFile);

        jsonFileContents.addAll(content);
        jsonFile.writeAsStringSync(jsonEncode(jsonFileContents));
      } else {
        createFile(
          content: content,
          pathToJSON: path,
        );
      }
    },
  );
}

createProgressFile() {
  getApplicationDocumentsDirectory().then((Directory dir) {
    var progressFile = File(dir.path + '/progressData.json');
    var dataFile = File(dir.path + '/learnData.json');
    var dataFileContents = json.decode(dataFile.readAsStringSync());

    if (!progressFile.existsSync()) {
      createFile(
        pathToJSON: dir.path + '/progressData.json',
        content: {},
      );
    }

    var progressFileContents = json.decode(progressFile.readAsStringSync());

    for (final category in progressFileContents.keys) {
      if (category == 'vocabulary')
        vocabularyProgress = progressFileContents[category]['data'];
      else if (category == 'conversation')
        conversationProgress = progressFileContents[category]['data'];
    }

    // updating vocabulary progress
    for (var i = 0; i < vocabulary.length; i++) {
      var index = vocabularyProgress.indexWhere((wordData) {
        return wordData.containsKey(vocabulary[i]['subCategory']);
      });

      if (index == -1) {
        vocabularyProgress.add(
          {
            'subCategory': dataFileContents['vocabulary'][i]['subCategory'],
            'data': [],
            'totalWords': vocabulary[i]['data'].length,
            'learnedWords': 0,
            'allWords': vocabulary[i]['data'],
          },
        );
      } else {
        vocabularyProgress[index]['totalWords'] = vocabulary[i]['data'].length;
        vocabularyProgress[index]['allWords'] = vocabulary[i]['data'];
      }
    }

    // updating conversation progress
    for (var i = 0; i < dataFileContents['conversation'].length; i++) {
      var index = conversationProgress.indexWhere((wordData) {
        return wordData
            .containsKey(dataFileContents['conversation'][i]['subCategory']);
      });

      if (index == -1) {
        conversationProgress.add(
          {
            'subCategory': dataFileContents['conversation'][i]['subCategory'],
            'data': [],
            'totalWords': conversation[i]['data'].length,
            'learnedWords': 0,
            'allWords': conversation[i]['data'],
          },
        );
      } else {
        conversationProgress[index]['totalWords'] =
            conversation[i]['data'].length;
        conversationProgress[index]['allWords'] = conversation[i]['data'];
      }
    }
    // print(conversationProgress[0]['allWords']);
    // print(conversationProgress[0]['allWords'].length);
    // print(conversation[0]['data']);
    // print(conversation[0]['data'].length);
    // print('progress file: ' + vocabularyProgress.length.toString());
    // print('progress file: ' + vocabulary.length.toString());
    // print('progress file: ' + vocabularyProgress.toString());
  });
}
