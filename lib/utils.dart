import 'dart:math';

String randomString(int length) {
  var r = Random.secure();
  var chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  return Iterable.generate(
    length,
    (_) => chars[r.nextInt(chars.length)],
  ).join();
}

bool isWebPath(String path) {
  return path.contains('http://') || path.contains('https://');
}
