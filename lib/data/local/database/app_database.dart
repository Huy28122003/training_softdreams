import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../domain/models/post.dart';
import '../../../utils/primary_key_helper.dart';
import 'dao/post_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Post])
abstract class AppDatabase extends FloorDatabase {
  PostDao get postDao;

  Future<List<T>> findAll<T>({
    required String tableName,
    required T Function(Map<String, dynamic> json) fromJson,
    String condition = '',
    List<String> orderBy = const [],
    int? offset,
    int? limit,
  }) async {
    final List<Map<String, dynamic>> output = await database.rawQuery(
      'SELECT * FROM $tableName '
      '${condition.isEmpty ? '' : 'WHERE $condition '}'
      '${orderBy.isEmpty ? '' : 'ORDER BY ${orderBy.map((e) {
          final [field, order] = e.split('_');
          return '$field $order';
        }).join(', ')}'} '
      'LIMIT ${limit ?? -1} '
      '${offset != null ? 'OFFSET $offset' : ''}',
    );

    return output.map<T>((json) => fromJson(json)).toList();
  }

  Future<int> count({
    required String tableName,
    String condition = '',
  }) async {
    final List<Map<String, dynamic>> output = await database.rawQuery(
      'SELECT COUNT(*) FROM $tableName '
      '${condition.isEmpty ? '' : 'WHERE $condition'}',
    );

    if (output.length != 1) return 0;

    return output.first.values.first as int;
  }

  Future<void> execute(String sql, [List<Object?>? arguments]) =>
      database.execute(sql, arguments);

  Future<int> insert(
    String table,
    Map<String, Object?> values, {
    String? nullColumnHack,
    sqflite.ConflictAlgorithm? conflictAlgorithm,
  }) {
    return database.insert(
      table,
      values,
      nullColumnHack: nullColumnHack,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  Future<List<int>> insertList(
    String table,
    List<Map<String, Object?>> values, {
    String? nullColumnHack,
    sqflite.ConflictAlgorithm? conflictAlgorithm,
  }) async {
    if (values.isEmpty) return [];
    final batch = database.batch();
    for (final value in values) {
      batch.insert(
        table,
        value,
        nullColumnHack: nullColumnHack,
        conflictAlgorithm: conflictAlgorithm,
      );
    }
    final result = (await batch.commit(noResult: false)).cast<int>();
    return result;
  }

  Future<int> update(
    String table,
    List<String> primaryKeyColumnName,
    Map<String, Object?> values, {
    sqflite.ConflictAlgorithm? conflictAlgorithm,
  }) {
    return database.update(
      table,
      values,
      where: PrimaryKeyHelper.getWhereClause(primaryKeyColumnName),
      whereArgs:
          PrimaryKeyHelper.getPrimaryKeyValues(primaryKeyColumnName, values),
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  Future<int> updateList(
    String table,
    List<String> primaryKeyColumnName,
    List<Map<String, Object?>> values, {
    sqflite.ConflictAlgorithm? conflictAlgorithm,
  }) async {
    if (values.isEmpty) return 0;
    final batch = database.batch();
    for (final value in values) {
      batch.update(
        table,
        value,
        where: PrimaryKeyHelper.getWhereClause(primaryKeyColumnName),
        whereArgs:
            PrimaryKeyHelper.getPrimaryKeyValues(primaryKeyColumnName, value),
        conflictAlgorithm: conflictAlgorithm,
      );
    }
    final result = (await batch.commit(noResult: false)).cast<int>();
    return result.fold<int>(
      0,
      (previousValue, element) => previousValue + element,
    );
  }
}
