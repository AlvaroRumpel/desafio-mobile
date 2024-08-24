import 'dart:developer';

class CustomException implements Exception {
  final String message;
  final String prefix;
  final Object? error;

  CustomException({
    this.message = '',
    this.prefix = '',
    this.error,
  }) {
    log('$runtimeType: $message${error != null ? "\n$error" : ''}');
  }

  @override
  String toString() {
    return message;
  }
}
