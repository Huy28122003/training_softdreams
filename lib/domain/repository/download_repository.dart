abstract class DownloadRepository {
  Future<bool> downloadFile({
    required List<String> urls,
    required String outputDir,
    Function(double)? onProgress,
    Function()? onCancel,
  });

  void cancelDownload(List<String> urls);
}
