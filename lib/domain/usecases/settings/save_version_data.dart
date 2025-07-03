import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../../repository/app_settings_repository.dart';
import '../usecase.dart';

class SaveVersionData implements UseCase<bool, String> {
  SaveVersionData(this._settingsRepository);

  final AppSettingsRepository _settingsRepository;

  @override
  Future<Either<Failure, bool>> call(String version) async {
    try {
      await _settingsRepository.saveVersionData(version);
      return const Right(true);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
