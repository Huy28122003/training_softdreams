import 'dart:io' as io;

import 'package:floor/floor.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/database/app_database.dart';
import '../../data/local/preference/app_preferences.dart';
import '../../utils/constants/strings.dart';
import '../locator.dart';

class LocalModule {
  LocalModule._();

  static Future<void> registerModule() async {
    await _provideSharedPreferences();
    _provideAppPreferences();
    await _provideAppDatabase();
  }

  static Future<void> _provideSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    locator.registerSingleton(sharedPreferences);
  }

  static void _provideAppPreferences() {
    locator.registerSingleton(AppPreferences(locator<SharedPreferences>()));
  }

  static Future<void> _initDatabasePath() async {
    final databasePath =
        await sqfliteDatabaseFactory.getDatabasePath(databaseName);

    final dbExists = await io.File(databasePath).exists();

    if (dbExists) return;

    ByteData data = await rootBundle.load(join('assets', databaseName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await io.File(databasePath).writeAsBytes(bytes, flush: true);
  }

  static Future<void> _provideAppDatabase() async {
    // TODO: add database
    // await _initDatabasePath();
    final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
    locator.registerSingleton(db);
  }
}
