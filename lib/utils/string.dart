import 'dart:math';

final Random random = Random();

String generateRandomString(int length, [String? allowedChars]) {
  final buffer = StringBuffer();
  final possible = allowedChars ??
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  possible[0];

  for (int i = 0; i < length; i += 1) {
    buffer.write(possible[(random.nextDouble() * possible.length).floor()]);
  }
  return buffer.toString();
}
