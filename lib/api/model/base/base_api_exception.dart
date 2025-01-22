class BaseApiException implements Exception {
  final String status;
  final String message;

  const BaseApiException({
    required this.status,
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}

class SsoException implements Exception {
  final String status;
  final String message;

  const SsoException({
    required this.status,
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}

class ApiException implements Exception {
  final String code;
  final String message;

  const ApiException({
    required this.code,
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}

class AdminException implements Exception {
  final String code;
  final String message;

  const AdminException({
    required this.code,
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}

class UploadFileException implements Exception {
  final String code;
  final String message;

  const UploadFileException({
    required this.code,
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}
