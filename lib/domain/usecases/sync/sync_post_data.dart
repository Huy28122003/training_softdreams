import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../../repository/sync_repository.dart';
import '../usecase.dart';

class SyncPostData implements UseCase<bool, NoParams> {
  SyncPostData({
    required this.syncRepository,
  });

  final SyncRepository syncRepository;

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) async {
    try {
      final value = await syncRepository.syncPostData();
      return Right(value);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
