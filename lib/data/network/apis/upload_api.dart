import 'dart:io';

import 'package:dio/dio.dart';

import '../../../domain/models/response/base_response.dart';
import '../../../utils/constants/url_constants.dart';
import '../client/none_auth_app_server_api_client.dart';

class UploadApi {
  UploadApi(this._restClient);

  final NoneAuthAppServerApiClient _restClient;

  Future<BaseResponse<String>> uploadFile(File file) async {
    try {
      final String path = file.path;
      final String filename = path.split('/').last;

      final formData = FormData.fromMap({
        'file': MultipartFile.fromFileSync(
          path,
          filename: filename,
        ),
      });

      final resp = await _restClient.post(UrlConstants.upload, data: formData);
      return BaseResponse.fromJson(
        resp as Map<String, dynamic>,
        (json) => json as String,
      );
    } on Exception {
      rethrow;
    }
  }
}
