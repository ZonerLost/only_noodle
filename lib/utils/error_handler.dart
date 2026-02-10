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
        final details = error['details'];
        if (details is List) {
          final detailMessages = details
              .whereType<Map<String, dynamic>>()
              .map((detail) {
                final field = detail['field']?.toString();
                final msg = detail['message']?.toString();
                if (field != null && field.isNotEmpty && msg != null && msg.isNotEmpty) {
                  return '$field: $msg';
                }
                return msg;
              })
              .whereType<String>()
              .where((value) => value.isNotEmpty)
              .toList();
          if (detailMessages.isNotEmpty) {
            return '${message.trim()} (${detailMessages.join(', ')})';
          }
        }
        return message;
      }
      final details = error['details'];
      if (details is List) {
        final detailMessages = details
            .whereType<Map<String, dynamic>>()
            .map((detail) {
              final field = detail['field']?.toString();
              final msg = detail['message']?.toString();
              if (field != null && field.isNotEmpty && msg != null && msg.isNotEmpty) {
                return '$field: $msg';
              }
              return msg;
            })
            .whereType<String>()
            .where((value) => value.isNotEmpty)
            .toList();
        if (detailMessages.isNotEmpty) {
          return detailMessages.join(', ');
        }
      }
    }
    final message = body['message'];
    if (message is String && message.isNotEmpty) {
      return message;
    }
    final errors = body['errors'];
    if (errors is List) {
      final detailMessages = errors
          .whereType<Map<String, dynamic>>()
          .map((detail) {
            final field = detail['field']?.toString();
            final msg = detail['message']?.toString();
            if (field != null && field.isNotEmpty && msg != null && msg.isNotEmpty) {
              return '$field: $msg';
            }
            return msg;
          })
          .whereType<String>()
          .where((value) => value.isNotEmpty)
          .toList();
      if (detailMessages.isNotEmpty) {
        return detailMessages.join(', ');
      }
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
