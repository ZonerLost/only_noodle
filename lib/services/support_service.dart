import 'api_client.dart';
import 'endpoints/support_endpoints.dart';

class SupportService {
  SupportService(this._client);

  final ApiClient _client;

  Future<List<Map<String, dynamic>>> getTickets() async {
    final data = await _client.get(SupportEndpoints.tickets);
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().toList();
    }
    return [];
  }

  Future<Map<String, dynamic>?> createTicket({
    required String subject,
    required String message,
    String? orderId,
  }) async {
    final data = await _client.post(
      SupportEndpoints.tickets,
      body: {
        'subject': subject,
        'message': message,
        if (orderId != null) 'orderId': orderId,
      },
    );
    if (data is Map<String, dynamic>) return data;
    return null;
  }

  Future<void> addMessage({
    required String ticketId,
    required String message,
  }) async {
    await _client.post(
      SupportEndpoints.messages(ticketId),
      body: {'message': message},
    );
  }
}
