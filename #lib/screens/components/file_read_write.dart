import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> get _localPath async {
  // final directory = await getApplicationDocumentsDirectory();
  final directory = await getExternalStorageDirectory();

  return directory!.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/details.txt');
}

Future<String> readDetails() async {
  try {
    final file = await _localFile;
    final contents = await file.readAsString();
    return contents;
  } catch (e) {
    return '';
  }
}

Future<File> writeDetails(String string) async {
  final file = await _localFile;
  return file.writeAsString(string);
}
