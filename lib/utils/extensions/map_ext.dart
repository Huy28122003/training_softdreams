extension MapExt on Map {
  void omitIsNil({bool deep = false, bool emptyString = true}) {
    final keys = List.from(this.keys);
    for (final key in keys) {
      final value = this[key];
      if (value is String) {
        if (emptyString && value.trim().isEmpty) remove(key);
      } else if (value is Map) {
        if (deep) value.omitIsNil(deep: deep);
      } else if (value == null) {
        remove(key);
      }
    }
  }

  void omitBy(
    List<String> listKeys, {
    bool deep = false,
  }) {
    if (listKeys.isEmpty) return;
    final keys = List.from(this.keys);
    for (final key in keys) {
      final value = this[key];
      if (listKeys.contains(key)) {
        remove(key);
      } else if (value is Map) {
        if (deep) value.omitBy(listKeys, deep: deep);
      }
    }
  }
}
