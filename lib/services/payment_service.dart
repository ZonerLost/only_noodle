import 'api_client.dart';
import 'endpoints/payment_endpoints.dart';

class PaymentService {
  PaymentService(this._client);

  final ApiClient _client;

  Future<Map<String, dynamic>?> createStripeIntent({
    required double amount,
    required String currency,
  }) async {
    final data = await _client.post(
      PaymentEndpoints.stripeIntent,
      body: {'amount': amount, 'currency': currency},
    );
    if (data is Map<String, dynamic>) return data;
    return null;
  }

  Future<Map<String, dynamic>?> confirmStripePayment({
    required String paymentIntentId,
  }) async {
    final data = await _client.post(
      PaymentEndpoints.stripeConfirm,
      body: {'paymentIntentId': paymentIntentId},
    );
    if (data is Map<String, dynamic>) return data;
    return null;
  }
}
