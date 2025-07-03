import 'dart:io';

import '../../domain/error/exception.dart';
import '../../domain/repository/upload_repository.dart';
import '../../utils/constants/nums.dart';
import '../../utils/extensions/list_ext.dart';
import '../network/apis/upload_api.dart';

class UploadRepositoryImpl extends UploadRepository {
  UploadRepositoryImpl(this.uploadApi);

  final UploadApi uploadApi;

  @override
  Future<String> uploadFile(File file) async {
    try {
      final bytes = file.readAsBytesSync().lengthInBytes;

      if (bytes >= maxFileSize) {
        throw const FileLargeException();
      }

      final resp = await uploadApi.uploadFile(file);

      if (!resp.status) throw Exception(resp.errors?.firstOrNull());

      return resp.data!;
    } catch (error) {
      throw AppException.throwException(error);
    }
  }
}
