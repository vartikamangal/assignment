import 'dart:ui';

/// Adds a delay of 2 seconds in any operation
void addDelay(VoidCallback callback) {
  Future.delayed(
    const Duration(seconds: 2),
    callback,
  );
}
