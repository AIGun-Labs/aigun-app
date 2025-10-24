import 'dart:math';

extension ListExtensions<T> on List<T> {
  T? getRandomItem() {
    if (isEmpty) return null;
    final random = Random();

    return this[random.nextInt(length)];
  }
}
