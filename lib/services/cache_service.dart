import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CacheService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/notes_cache.json');
  }

  Future<File> writeNotes(String notes) async {
    final file = await _localFile;
    return file.writeAsString(notes);
  }

  Future<String?> readNotes() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        return await file.readAsString();
      }
    } catch (e) {
      // Eğer bir hata oluşursa, null döner
      print("Cache read error: $e");
    }
    return null;
  }
}
