class UserEndpoints {
  static const me = '/users/me';
  static const addresses = '/users/me/addresses';

  static String addressById(String id) => '/users/me/addresses/$id';
  static String defaultAddress(String id) =>
      '/users/me/addresses/$id/default';
}
