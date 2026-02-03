class SupportEndpoints {
  static const tickets = '/support/tickets';

  static String ticketById(String id) => '/support/tickets/$id';
  static String messages(String id) => '/support/tickets/$id/messages';
}
