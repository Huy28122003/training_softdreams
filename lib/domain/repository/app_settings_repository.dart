abstract class AppSettingsRepository {
  String? get versionData;

  Future<void> saveVersionData(String version);
}
