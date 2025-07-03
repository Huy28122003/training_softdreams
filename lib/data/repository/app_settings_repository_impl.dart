import '../../domain/repository/app_settings_repository.dart';
import '../local/preference/app_preferences.dart';

class AppSettingsRepositoryImpl extends AppSettingsRepository {
  AppSettingsRepositoryImpl(this._preferences);

  final AppPreferences _preferences;

  @override
  String? get versionData => _preferences.versionData;

  @override
  Future<void> saveVersionData(String version) {
    return _preferences.saveVersionData(version);
  }
}
