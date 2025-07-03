import 'package:sqflite/sqflite.dart';

import '../../domain/repository/sync_repository.dart';
import '../../utils/constants/strings.dart';
import '../../utils/extensions/date_ext.dart';
import '../local/database/app_database.dart';
import '../network/apis/sync_api.dart';

class SyncRepositoryImpl extends SyncRepository {
  SyncRepositoryImpl({
    required this.syncApi,
    required this.database,
  });

  final SyncApi syncApi;
  final AppDatabase database;

  @override
  Future<bool> syncPostData() async {
    final data = await syncApi.fetchPostData();
    // TODO: get last time updated
    final lastTimeUpdated = DateTime(2023, 10, 10);

    for (final json in data) {
      final date = DateExt.parseUtc(json['date'] as String);
      if (date == null || date.compareTo(lastTimeUpdated) != 1) {
        continue;
      }

      final Map<String, dynamic>? newJsonData =
          json['new_data'] as Map<String, dynamic>?;
      if (newJsonData != null) {
        await database.insertList(
          postsTableName,
          (newJsonData['posts'] as List).cast<Map<String, dynamic>>(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }

      final Map<String, dynamic>? updateJsonData =
          json['update_data'] as Map<String, dynamic>?;
      if (updateJsonData != null) {
        await database.updateList(
          postsTableName,
          ['id'],
          (updateJsonData['posts'] as List).cast<Map<String, dynamic>>(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    }

    // TODO: save last time updated

    return true;
  }
}
