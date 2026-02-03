class NotificationEndpoints {
  static const notifications = '/notifications';
  static const unreadCount = '/notifications/unread-count';
  static const readAll = '/notifications/read-all';

  static String markRead(String id) => '/notifications/$id/read';
  static String delete(String id) => '/notifications/$id';
}
