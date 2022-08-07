import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'dart:io';
 
class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }
 
  static Future<File> get getFile async {
    final path = await getFilePath;
    print('$path/myfile.txt');
    return File('$path/myfile.txt');
  }
 
  static Future<File> saveToFile(Map data) async {
    final file = await getFile;
    return file.writeAsString(json.encode(data));
  }
 
  static Future<Map> readFromFile() async {
    try {
      final file = await getFile;
      String fileContents = await file.readAsString();
      return json.decode(fileContents);
      // return fileContents;
    } catch (e) {
      return {};
    }
  }
}