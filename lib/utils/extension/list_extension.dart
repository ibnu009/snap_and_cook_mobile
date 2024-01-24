extension ListKt<T> on Iterable<T> {
  ///forEach with index
  void forEachIndexed(void Function(int index, T element) action) {
    int index = 0;

    for (T element in this) {
      action(index++, element);
    }
  }
}