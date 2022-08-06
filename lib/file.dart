import 'dart:convert';
import 'dart:io';

// class FileHandler {
  
//   // Makes this a singleton class, as we want only want a single
//   // instance of this object for the whole application
//   FileHandler._privateConstructor();
//   static final FileHandler instance = FileHandler._privateConstructor();
// }

// static File? _file;

//   static final _fileName = 'user_file.txt';

//   // Get the data file
//   Future<File> get file async {
//     if (_file != null) return _file!;

//     _file = await _initFile();
//     return _file!;
//   }

//   // Inititalize file
//   Future<File> _initFile() async {
// final _directory = await getApplicationDocumentsDirectory();
//     final _path = _directory.path;
//     return File('$_path/$_fileName');
//   }
Future<Map<String, dynamic>> _read() async {
  final file = File('assets/data');
  final jsonStr = await file.readAsString();

  return jsonDecode(jsonStr) as Map<String, dynamic>;
}

Future<void> _write(Map<String, dynamic> map) async {
  final jsonStr = jsonEncode(map);

  final file = File('assets/data');

  await file.writeAsString(jsonStr);
}