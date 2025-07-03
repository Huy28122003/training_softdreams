import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../../repository/download_repository.dart';
import '../usecase.dart';

class CancelDownload implements UseCase<bool, List<String>> {
  CancelDownload(this.downloadRepository);

  final DownloadRepository downloadRepository;

  @override
  Future<Either<Failure, bool>> call(List<String> urls) async {
    try {
      downloadRepository.cancelDownload(urls);
      return const Right(true);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
