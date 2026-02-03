class DriverEndpoints {
  static const profile = '/driver/profile';
  static const location = '/driver/location';
  static const orders = '/driver/orders';
  static const history = '/driver/history';
  static const tips = '/driver/tips';
  static const stats = '/driver/stats';
  static const support = '/driver/support';

  static String orderById(String id) => '/driver/orders/$id';
  static String acceptOrder(String id) => '/driver/orders/$id/accept';
  static String updateStatus(String id) => '/driver/orders/$id/status';
}
