class OrderEndpoints {
  static const orders = '/orders';

  static String orderById(String id) => '/orders/$id';
  static String track(String id) => '/orders/$id/track';
  static String cancel(String id) => '/orders/$id/cancel';
  static String review(String id) => '/orders/$id/review';
  static String reorder(String id) => '/orders/$id/reorder';
}
