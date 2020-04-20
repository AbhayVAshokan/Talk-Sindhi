import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import './realtime_data.dart';

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
  // Function to return the location at which the data is stored locally.
  getApplicationDocumentsDirectory().then(
    (Directory dir) {
      var path = dir.path + '/' + fileName;
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

// Check internet connectivity asynchronously.
Future<ConnectivityResult> checkConnectivity() async {
  return await (Connectivity().checkConnectivity());
}

var directoryPath;
// Sync local data with server data.
syncWithServer(response) {
  var vocabularyData = [];
  var conversationData = [];
  var apiResponse = json.decode(response.body) as Map;

  for (var i = 0; i < apiResponse['data'].length; i++) {
    // Parsing vocabulary data
    if (apiResponse['data'][i]['SubCategory']['Category']['name'] ==
        'vocabulary') {
      var index = vocabularyData.indexWhere((element) =>
          element['subCategory'] ==
          apiResponse['data'][i]['SubCategory']['name']);

      var media = apiResponse['data'][i]['media'] == null
          ? null
          : apiResponse['data'][i]['media']['url'];

      // if media is not already downloaded, download so that it is available offline
      if (media != null &&
          !File('$directoryPath/${apiResponse['data'][i]['sindhi']}.mp3')
              .existsSync())
        downloadFile(media, apiResponse['data'][i]['sindhi'] + '.mp3');

      if (index == -1)
        vocabularyData.add(
          {
            'subCategory': apiResponse['data'][i]['SubCategory']['name'],
            'data': [
              {
                'english': apiResponse['data'][i]['english'],
                'hindi': apiResponse['data'][i]['hindi'],
                'sindhi': apiResponse['data'][i]['sindhi'],
                'media': media,
              },
            ],
          },
        );
      else
        vocabularyData[index]['data'].add(
          {
            'english': apiResponse['data'][i]['english'],
            'hindi': apiResponse['data'][i]['hindi'],
            'sindhi': apiResponse['data'][i]['sindhi'],
            'media': media,
          },
        );
    }

    // Parsing conversation data
    else if (apiResponse['data'][i]['SubCategory']['Category']['name'] ==
        'Conversation') {
      var index = conversationData.indexWhere((element) =>
          element['subCategory'] ==
          apiResponse['data'][i]['SubCategory']['name']);

      var media = apiResponse['data'][i]['media'] == null
          ? null
          : apiResponse['data'][i]['media']['url'];

      if (index == -1)
        conversationData.add(
          {
            'subCategory': apiResponse['data'][i]['SubCategory']['name'],
            'data': [
              {
                'english': apiResponse['data'][i]['english'],
                'hindi': apiResponse['data'][i]['hindi'],
                'sindhi': apiResponse['data'][i]['sindhi'],
                'media': media,
              },
            ],
          },
        );
      else
        conversationData[index]['data'].add(
          {
            'english': apiResponse['data'][i]['english'],
            'hindi': apiResponse['data'][i]['hindi'],
            'sindhi': apiResponse['data'][i]['sindhi'],
            'media': media,
          },
        );
    }
  }

  // Update progress data
  updateLocalData(vocabularyData, conversationData);

  // Build searchBar list
  createSearchList();
}

// Loading local data as real-time data.
loadLocalData() {
  getApplicationDocumentsDirectory().then(
    (Directory dir) {
      directoryPath = dir.path;
      var progressFile = File(dir.path + '/progressData.json');
      if (progressFile.existsSync()) {
        var localData = json.decode(progressFile.readAsStringSync());
        for (final category in localData.keys) {
          if (category == 'vocabulary')
            vocabulary = localData['vocabulary'];
          else if (category == 'conversation')
            conversation = localData['conversation'];
        }
      }
      createSearchList();
    },
  );
}

// update local data (progress)
updateLocalData(vocabularyData, conversationData) {
  getApplicationDocumentsDirectory().then(
    (Directory dir) {
      File progressFile = File(dir.path + '/progressData.json');
      if (!progressFile.existsSync()) {
        var content = {
          'vocabulary': [],
          'conversation': [],
        };

        for (var i = 0; i < vocabularyData.length; i++) {
          content['vocabulary'].add(
            {
              'subCategory': vocabularyData[i]['subCategory'],
              'data': [],
              'totalWords': 0,
              'learnedWords': [],
            },
          );
        }
        for (var i = 0; i < conversationData.length; i++) {
          content['conversation'].add(
            {
              'subCategory': conversationData[i]['subCategory'],
              'data': [],
              'totalWords': 0,
              'learnedWords': [],
            },
          );
        }

        createFile(
          content: content,
          pathToJSON: dir.path + '/progressData.json',
        );
      }

      var progressFileData = json.decode(progressFile.readAsStringSync());

      // updating vocabulary data.
      for (var i = 0; i < vocabularyData.length; i++) {
        var subCategoryIndex = progressFileData['vocabulary'].indexWhere(
          (wordData) =>
              wordData['subCategory'] == vocabularyData[i]['subCategory'],
        );

        if (subCategoryIndex == -1) {
          var content = {
            'subCategory': vocabularyData[i]['subCategory'],
            'data': vocabularyData[i]['data'],
            'totalWords': vocabularyData[i]['data'].length,
            'learnedWords': [],
          };
          progressFileData['vocabulary'].add(content);
        } else {
          progressFileData['vocabulary'][subCategoryIndex] = {
            'subCategory': vocabularyData[i]['subCategory'],
            'data': vocabularyData[i]['data'],
            'totalWords': vocabularyData[i]['data'].length,
            'learnedWords': progressFileData['vocabulary'][subCategoryIndex]
                ['learnedWords'],
          };
        }
      }

      // updating conversation data.
      for (var i = 0; i < conversationData.length; i++) {
        var subCategoryIndex = progressFileData['conversation'].indexWhere(
          (wordData) =>
              wordData['subCategory'] == conversationData[i]['subCategory'],
        );

        if (subCategoryIndex == -1) {
          var content = {
            'subCategory': conversationData[i]['subCategory'],
            'data': conversationData[i]['data'],
            'totalWords': conversationData[i]['data'].length,
            'learnedWords': [],
          };
          progressFileData['conversation'].add(content);
        } else {
          progressFileData['conversation'][subCategoryIndex] = {
            'subCategory': conversationData[i]['subCategory'],
            'data': conversationData[i]['data'],
            'totalWords': conversationData[i]['data'].length,
            'learnedWords': progressFileData['conversation'][subCategoryIndex]
                ['learnedWords'],
          };
        }
      }

      // Sorting data
      // 1. vocabulary
      for (var i = 0; i < progressFileData['vocabulary'].length; i++) {
        (progressFileData['vocabulary'][i]['data']
                as List<Map<String, dynamic>>)
            .sort(
          (word1, word2) => word1['english'].compareTo(
            word2['english'],
          ),
        );
      }
      for (var i = 0; i < progressFileData['vocabulary'].length; i++) {
        for (var j = i + 1; j < progressFileData['vocabulary'].length; j++) {
          if (progressFileData['vocabulary'][i]['subCategory']
                  .compareTo(progressFileData['vocabulary'][j]['subCategory']) >
              0) {
            var temp = progressFileData['vocabulary'][j];
            progressFileData['vocabulary'][j] =
                progressFileData['vocabulary'][i];
            progressFileData['vocabulary'][i] = temp;
          }
        }
      }

      // 2. conversation

      for (var i = 0; i < progressFileData['conversation'].length; i++) {
        for (var j = i + 1; j < progressFileData['conversation'].length; j++) {
          if (progressFileData['conversation'][i]['subCategory'].compareTo(
                  progressFileData['conversation'][j]['subCategory']) >
              0) {
            var temp = progressFileData['conversation'][j];
            progressFileData['conversation'][j] =
                progressFileData['conversation'][i];
            progressFileData['conversation'][i] = temp;
          }
        }
      }

      writeToFile(content: progressFileData, fileName: '/progressData.json');
      vocabulary = progressFileData['vocabulary'];
      conversation = progressFileData['conversation'];
    },
  );

  Fluttertoast.showToast(
    msg: "Finished syncing with server",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black87,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

// Downloading files from server
downloadFile(String url, String fileName) async {
  print('downloading file');
  getApplicationDocumentsDirectory().then(
    (Directory dir) async {
      var file = File('${dir.path}/$fileName');
      var request = await http.get(url);
      var bytes = request.bodyBytes;
      file.writeAsBytesSync(bytes);
      print('downloaded file: ${file.path}' + file.existsSync().toString());
    },
  );
}

// Creating searchList for the searchBar
createSearchList() {
  List<Map<String, dynamic>> placeholder = [];
  for (var i = 0; i < vocabulary.length; i++) {
    for (var j = 0; j < vocabulary[i]['data'].length; j++) {
      placeholder.add({
        'category': 'vocabulary',
        'subCategory': vocabulary[i],
        'subCategoryIndex': i,
        'rebuildScreen': () {},
        'initialIndex': j,
      });
    }
  }

  for (var i = 0; i < conversation.length; i++) {
    for (var j = 0; j < conversation[i]['data'].length; j++) {
      placeholder.add({
        'category': 'conversation',
        'subCategory': conversation[i],
        'subCategoryIndex': i,
        'rebuildScreen': () {},
        'initialIndex': j,
      });
    }
  }
  searchItems = placeholder;
}
