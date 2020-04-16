import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

// Create the local JSON file
void createFile({
  Map<String, dynamic> content,
  String pathToJSON,
}) {
  File file = File(pathToJSON);
  file.createSync();
  file.writeAsStringSync(jsonEncode(content));
}

// Write content into local JSON file
void writeToFile({
  Map<String, dynamic> content,
}) {
  Directory directory;
  String fileName = 'userData.json';

  // Function to return the location at which the data is stored locally.
  getApplicationDocumentsDirectory().then(
    (Directory dir) {
      directory = dir;
      var path = directory.path + '/' + fileName;
      var jsonFile = File(path);

      bool fileExists = jsonFile.existsSync();
      if (fileExists) {
        print('file already exists: ' + jsonFile.readAsStringSync());
      }

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
      print('file contents: ' + jsonFile.readAsStringSync());
    },
  );
}

// Funtion to read and return the JSON file contents
void readFromFile(fileContent) {
   Directory directory;
  String fileName = 'userData.json';

  // Function to return the location at which the data is stored locally.
  getApplicationDocumentsDirectory().then(
    (Directory dir) {
      directory = dir;
      var path = directory.path + '/' + fileName;
      var jsonFile = File(path);
      print('--------------------------------------');
      print(json.decode(jsonFile.readAsStringSync()));
      fileContent =  json.decode(jsonFile.readAsStringSync());
    },
  );
}
