import 'package:dio/dio.dart';

import '../client/none_auth_app_server_api_client.dart';

class DownloadApi {
  DownloadApi(this._restClient) : _cancelTokens = {};

  final NoneAuthAppServerApiClient _restClient;

  final Map<String, CancelToken> _cancelTokens;

  Future<void> downloadFile(
    String url,
    String saveFilePath, {
    ProgressCallback? progressCallback,
  }) async {
    try {
      _cancelTokens[url] = CancelToken();
      await _restClient.download(
        url,
        saveFilePath,
        cancelToken: _cancelTokens[url],
        onReceiveProgress: progressCallback,
      );
    } on Exception {
      rethrow;
    }
  }

  void cancelDownload(String url) => _cancelTokens[url]?.cancel();
}
