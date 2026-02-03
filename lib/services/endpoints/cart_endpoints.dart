class CartEndpoints {
  static const cart = '/cart';
  static const items = '/cart/items';
  static const calculate = '/cart/calculate';
  static const applyPromo = '/cart/apply-promo';
  static const removePromo = '/cart/promo';
  static const bonusEligibility = '/cart/bonus-eligibility';

  static String itemById(String id) => '/cart/items/$id';
}
