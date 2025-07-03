import 'dart:io';

abstract class UploadRepository {
  Future<String> uploadFile(File file);
}
