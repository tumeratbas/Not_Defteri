import 'dart:io';

Future<File> compressImage(File imageFile) async {
  final bytes = await imageFile.readAsBytes();
  var img;
  final compressedImage = img.decodeImage(bytes);

  final tempDir = Directory.systemTemp;
  final compressedPath = '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

  final compressedFile = File(compressedPath);
  await compressedFile.writeAsBytes(img.encodeJpg(compressedImage!, quality: 85));

  return compressedFile;
}
