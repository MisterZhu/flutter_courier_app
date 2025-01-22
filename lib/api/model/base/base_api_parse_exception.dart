class BaseApiParseException implements Exception {
  final String message;

  const BaseApiParseException({
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}
