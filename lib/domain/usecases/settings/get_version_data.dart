import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../../repository/app_settings_repository.dart';
import '../usecase.dart';

class GetVersionData implements UseCase<String?, NoParams> {
  GetVersionData(this._settingsRepository);

  final AppSettingsRepository _settingsRepository;

  @override
  Future<Either<Failure, String?>> call([NoParams? params]) async {
    try {
      final versionData = _settingsRepository.versionData;
      return Right(versionData);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
