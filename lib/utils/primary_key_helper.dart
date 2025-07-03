class PrimaryKeyHelper {
  static String getWhereClause(final List<String> groupPrimaryKey) {
    return groupPrimaryKey.map((columnName) => '$columnName = ?').join(' AND ');
  }

  static List<Object> getPrimaryKeyValues(
    final List<String> primaryKeys,
    final Map<String, Object?> values,
  ) {
    return primaryKeys.mapNotNull((key) => values[key]).toList();
  }
}

extension<T> on Iterable<T> {
  Iterable<R> mapNotNull<R>(R? Function(T element) transform) sync* {
    for (final element in this) {
      final transformed = transform(element);
      if (transformed != null) yield transformed;
    }
  }
}
