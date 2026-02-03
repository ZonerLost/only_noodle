class ApiException implements Exception {
  final int statusCode;
  final String message;
  final dynamic details;

  ApiException({
    required this.statusCode,
    required this.message,
    this.details,
  });

  @override
  String toString() => 'ApiException($statusCode): $message';
}

String parseApiErrorMessage(dynamic body, int statusCode) {
  if (body is Map<String, dynamic>) {
    final error = body['error'];
    if (error is Map<String, dynamic>) {
      final message = error['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }
    final message = body['message'];
    if (message is String && message.isNotEmpty) {
      return message;
    }
    final data = body['data'];
    if (data is Map<String, dynamic>) {
      final msg = data['message'];
      if (msg is String && msg.isNotEmpty) {
        return msg;
      }
    }
  }
  if (statusCode == 401) {
    return 'Your session has expired. Please login again.';
  }
  if (statusCode == 403) {
    return 'You do not have permission to perform this action.';
  }
  if (statusCode >= 500) {
    return 'Server error. Please try again later.';
  }
  return 'Something went wrong. Please try again.';
}
