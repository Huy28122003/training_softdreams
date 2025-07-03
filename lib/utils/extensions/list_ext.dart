extension ListExt<T> on List<T> {
  List<T> sortedByDescending(Comparable Function(T element) selector) {
    final newList = List<T>.from(this);
    newList.sort((a, b) {
      final value1 = selector(a);
      final value2 = selector(b);
      return value2.compareTo(value1);
    });
    return newList;
  }

  T? firstOrNull() {
    if (!isEmpty) return first;
    return null;
  }

  T? lastOrNull() {
    if (!isEmpty) return last;
    return null;
  }

  T? firstOrNullWhere(bool Function(T) test) {
    final index = indexWhere(test);
    if (index == -1) return null;
    return elementAt(index);
  }

  List<List<T>> chunk(int size) {
    int chunks = (length / size).ceil();
    return List.generate(chunks, (i) => skip(i * size).take(size).toList());
  }

  List<T> not(List<T> other, {bool Function(T, T)? compare}) {
    return where((ele) {
      final indexWhere = other.indexWhere((other) {
        if (compare != null) {
          return compare(ele, other);
        }
        return ele == other;
      });
      return indexWhere == -1;
    }).toList();
  }

  T? elementAtOrNull(int index) {
    if (index < length) return elementAt(index);
    return null;
  }
}

extension IterableNullableExt<T extends Object> on Iterable<T?> {
  Iterable<T> whereNotNull([bool Function(T)? test]) sync* {
    for (var element in this) {
      if (element != null) {
        if (test?.call(element) ?? true) yield element;
      }
    }
  }
}
