class ZoneEndpoints {
  static const list = '/zones';
  static const validate = '/zones/validate';
  static const slots = '/zones/slots';
  static const check = '/zones/check';

  static String fees(String id) => '/zones/$id/fees';
}
