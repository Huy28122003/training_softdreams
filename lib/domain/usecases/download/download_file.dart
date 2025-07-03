import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../../repository/download_repository.dart';
import '../usecase.dart';

class DownloadFile implements UseCase<bool, DownloadFileParams> {
  DownloadFile(this.downloadRepository);

  final DownloadRepository downloadRepository;

  @override
  Future<Either<Failure, bool>> call(DownloadFileParams params) async {
    try {
      final value = await downloadRepository.downloadFile(
        urls: params.urls,
        outputDir: params.outputDir,
        onProgress: params.onProgress,
        onCancel: params.onCancel,
      );
      return Right(value);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}

class DownloadFileParams {
  final List<String> urls;
  final String outputDir;
  final Function(double)? onProgress;
  final Function()? onCancel;

  DownloadFileParams({
    required this.urls,
    required this.outputDir,
    this.onProgress,
    this.onCancel,
  });
}
