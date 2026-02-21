import 'address.dart';

class Order {
  final String id;
  final String orderNumber;
  final String status;
  final String type;
  final List<dynamic> items;
  final double subtotal;
  final double deliveryFee;
  final double tip;
  final double discount;
  final double total;
  final String paymentMethod;
  final String paymentStatus;
  final String customerName;
  final String customerPhone;
  final Address? address;
  final DateTime? createdAt;
  final DateTime? estimatedDeliveryTime;

  const Order({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.type,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tip,
    required this.discount,
    required this.total,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.customerName,
    required this.customerPhone,
    required this.address,
    required this.createdAt,
    required this.estimatedDeliveryTime,
  });

  static double _computeSubtotal(List<dynamic> items) {
    double sum = 0;
    for (final item in items) {
      if (item is! Map<String, dynamic>) continue;
      final total = item['total'] ?? item['itemTotal'];
      if (total is num) {
        sum += total.toDouble();
        continue;
      }
      final price = item['price'] ?? item['unitPrice'];
      final qty = item['quantity'];
      if (price is num && qty is num) {
        sum += price.toDouble() * qty.toDouble();
      }
    }
    return sum;
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List?) ?? const [];
    final subtotalValue = (json['subtotal'] as num?)?.toDouble();
    return Order(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      orderNumber: (json['orderNumber'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      items: items,
      subtotal: subtotalValue ?? _computeSubtotal(items),
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0,
      tip: (json['tip'] as num?)?.toDouble() ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0,
      paymentMethod: (json['paymentMethod'] ?? '').toString(),
      paymentStatus: (json['paymentStatus'] ?? '').toString(),
      customerName: (json['customerName'] ?? '').toString(),
      customerPhone: (json['customerPhone'] ?? '').toString(),
      address: json['address'] is Map<String, dynamic>
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'].toString()),
      estimatedDeliveryTime: json['estimatedDeliveryTime'] == null
          ? null
          : DateTime.tryParse(json['estimatedDeliveryTime'].toString()),
    );
  }
}
