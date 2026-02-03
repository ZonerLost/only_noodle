import 'product.dart';

class CartItem {
  final String id;
  final Product? product;
  final int quantity;
  final List<dynamic> selectedOptions;
  final List<dynamic> selectedExtras;
  final String notes;
  final double itemTotal;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.selectedOptions,
    required this.selectedExtras,
    required this.notes,
    required this.itemTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: (json['id'] ?? '').toString(),
      product: json['product'] is Map<String, dynamic>
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      selectedOptions: (json['selectedOptions'] as List?) ?? const [],
      selectedExtras: (json['selectedExtras'] as List?) ?? const [],
      notes: (json['notes'] ?? '').toString(),
      itemTotal: (json['itemTotal'] as num?)?.toDouble() ?? 0,
    );
  }
}

class Cart {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double subtotal;
  final String promoCode;
  final double discount;

  const Cart({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.promoCode,
    required this.discount,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(CartItem.fromJson)
        .toList();
    return Cart(
      id: (json['id'] ?? '').toString(),
      userId: (json['userId'] ?? '').toString(),
      items: items,
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
      promoCode: (json['promoCode'] ?? '').toString(),
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
    );
  }
}
