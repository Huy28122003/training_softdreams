import 'package:dio/dio.dart';

import '../../core/uncompress_delegate/uncompress_delegate.dart';
import '../../core/uncompress_delegate/unzip_delegate.dart';
import '../../domain/repository/download_repository.dart';
import '../../utils/file.dart';
import '../local/preference/app_preferences.dart';
import '../network/apis/download_api.dart';

class DownloadRepositoryImpl extends DownloadRepository {
  DownloadRepositoryImpl({
    required this.downloadApi,
    required this.preferences,
  });

  final DownloadApi downloadApi;
  final AppPreferences preferences;

  final _threshold = 98.0;
  final _maxTotal = 100.0;

  @override
  Future<bool> downloadFile({
    required List<String> urls,
    required String outputDir,
    List<UncompressDelegate> uncompressDelegates = const [UnzipDelegate()],
    Function(double)? onProgress,
    Function()? onCancel,
  }) async {
    if (urls.isEmpty) return false;

    try {
      double totalProgress = 0.0;
      onProgress?.call(totalProgress);

      await FileUtils().createDirectory(outputDir);

      for (final url in urls) {
        final fileName = FileUtils().getFileName(url);
        final fileExtension = FileUtils().getFileExtension(url);
        final fullPath = '$outputDir/$fileName';
        double previousProgress = 0.0;

        await downloadApi.downloadFile(
          url,
          fullPath,
          progressCallback: (received, total) {
            if (total == -1) {
              return;
            }

            final progress = (received / total) * _maxTotal;
            final increment = progress - previousProgress;
            totalProgress += increment;
            previousProgress = progress;

            if (totalProgress >= _threshold || increment <= 0.1) {
              return;
            }

            onProgress?.call(totalProgress);
          },
        );

        for (final delegate in uncompressDelegates) {
          if (delegate.extension == fileExtension) {
            await delegate.uncompress(fullPath, outputDir);
            break;
          }
        }
      }

      if (totalProgress >= _threshold) {
        onProgress?.call(_maxTotal);
      }

      return true;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.cancel) {
        onCancel?.call();
        return false;
      }

      rethrow;
    }
  }

  @override
  void cancelDownload(List<String> urls) {
    for (final url in urls) {
      downloadApi.cancelDownload(url);
    }
  }
}
