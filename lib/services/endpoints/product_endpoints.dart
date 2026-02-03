class ProductEndpoints {
  static const list = '/products';
  static const featured = '/products/featured';
  static const search = '/products/search';

  static String details(String id) => '/products/$id';
}
