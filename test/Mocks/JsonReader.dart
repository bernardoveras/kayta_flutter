import 'dart:io';

///https://stackoverflow.com/questions/45780255/flutter-how-to-load-file-for-testing
String jsonReader(String name) {
  String path = 'test/Mocks/Json/$name';
  try {
    return File(path).readAsStringSync();
  } catch (e) {
    return File("../$path").readAsStringSync();
  }
}
