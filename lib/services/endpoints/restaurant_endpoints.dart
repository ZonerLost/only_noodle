class RestaurantEndpoints {
  static const list = '/restaurants';
  static const nearby = '/restaurants/nearby';
  static const search = '/restaurants/search';
  static const promoValidate = '/restaurants/promo/validate';

  static String details(String id) => '/restaurants/$id';
  static String menu(String id) => '/restaurants/$id/menu';
  static String reviews(String id) => '/restaurants/$id/reviews';
}
