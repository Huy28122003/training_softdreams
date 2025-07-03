import 'dart:io';

import 'package:archive/archive.dart';

import '../../utils/extensions/list_ext.dart';
import '../../utils/file.dart';
import 'uncompress_delegate.dart';

class UnzipDelegate implements UncompressDelegate {
  const UnzipDelegate();

  @override
  String get extension => '.zip';

  @override
  Future uncompress(
    String compressedFilePath,
    String outputDir, [
    bool extractHere = true,
  ]) async {
    if (!extractHere) {
      final fileName = FileUtils().getFileName(compressedFilePath);
      final subDir = fileName.split('.')[0];
      outputDir = '$outputDir/$subDir';
      await FileUtils().createDirectory(outputDir);
    }

    final compressedFile = File(compressedFilePath);
    final bytes = await compressedFile.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);
    await compressedFile.delete();

    final chunks = archive.files.chunk(50);
    for (var files in chunks) {
      await Future.wait(files.map((file) async {
        if (!file.isFile) {
          return;
        }

        final fileName = '$outputDir/${file.name}';
        final outFile = await File(fileName).create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }));
    }
  }
}
