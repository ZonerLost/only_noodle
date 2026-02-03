import '../models/notification_model.dart';
import 'api_client.dart';
import 'endpoints/notification_endpoints.dart';

class NotificationService {
  NotificationService(this._client);

  final ApiClient _client;

  Future<List<AppNotification>> getNotifications() async {
    final data = await _client.get(NotificationEndpoints.notifications);
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(AppNotification.fromJson)
          .toList();
    }
    return [];
  }

  Future<int> getUnreadCount() async {
    final data = await _client.get(NotificationEndpoints.unreadCount);
    if (data is Map<String, dynamic>) {
      return (data['count'] as num?)?.toInt() ?? 0;
    }
    return 0;
  }

  Future<void> markAllRead() async {
    await _client.patch(NotificationEndpoints.readAll);
  }

  Future<void> markRead(String id) async {
    await _client.patch(NotificationEndpoints.markRead(id));
  }

  Future<void> deleteNotification(String id) async {
    await _client.delete(NotificationEndpoints.delete(id));
  }
}
