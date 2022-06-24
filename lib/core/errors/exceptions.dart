class AppException implements Exception {
  AppException([this.message, this.stackTrace = StackTrace.empty]);

  final String? message;
  final StackTrace? stackTrace;

  @override
  String toString() =>
      message == null ? '$runtimeType' : '$runtimeType($message)';
}

class ServerException extends AppException {
  ServerException(String? message) : super(message);
}

class CacheException extends AppException {
  CacheException(String? message) : super(message);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException({String? message}) : super(message);
}
