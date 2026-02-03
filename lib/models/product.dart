class ProductOptionChoice {
  final String name;
  final double price;

  const ProductOptionChoice({
    required this.name,
    required this.price,
  });

  factory ProductOptionChoice.fromJson(Map<String, dynamic> json) {
    return ProductOptionChoice(
      name: (json['name'] ?? '').toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
    );
  }
}

class ProductOption {
  final String name;
  final bool required;
  final List<ProductOptionChoice> choices;

  const ProductOption({
    required this.name,
    required this.required,
    required this.choices,
  });

  factory ProductOption.fromJson(Map<String, dynamic> json) {
    final choices = (json['choices'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(ProductOptionChoice.fromJson)
        .toList();
    return ProductOption(
      name: (json['name'] ?? '').toString(),
      required: json['required'] == true,
      choices: choices,
    );
  }
}

class ProductExtra {
  final String name;
  final double price;

  const ProductExtra({
    required this.name,
    required this.price,
  });

  factory ProductExtra.fromJson(Map<String, dynamic> json) {
    return ProductExtra(
      name: (json['name'] ?? '').toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
    );
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  final bool isAvailable;
  final bool isFeatured;
  final List<ProductOption> options;
  final List<ProductExtra> extras;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.isAvailable,
    required this.isFeatured,
    required this.options,
    required this.extras,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final options = (json['options'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(ProductOption.fromJson)
        .toList();
    final extras = _parseExtras(json);
    return Product(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
      imageUrl: (json['imageUrl'] ?? '').toString(),
      categoryId: (json['categoryId'] ?? json['category'] ?? '').toString(),
      isAvailable: json['isAvailable'] == true || json['available'] == true,
      isFeatured: json['isFeatured'] == true,
      options: options,
      extras: extras,
    );
  }

  static List<ProductExtra> _parseExtras(Map<String, dynamic> json) {
    final extrasRaw = json['extras'];
    if (extrasRaw is List) {
      return extrasRaw
          .whereType<Map<String, dynamic>>()
          .map(ProductExtra.fromJson)
          .toList();
    }
    final addOnsRaw = json['addOns'];
    if (addOnsRaw is List) {
      return addOnsRaw.map<ProductExtra>((item) {
        if (item is Map<String, dynamic>) {
          return ProductExtra.fromJson(item);
        }
        if (item is String) {
          final nameMatch = RegExp(r'name=([^;\\}]+)').firstMatch(item);
          final priceMatch = RegExp(r'price=([0-9.]+)').firstMatch(item);
          final name = nameMatch?.group(1)?.trim() ?? item;
          final price = double.tryParse(priceMatch?.group(1) ?? '') ?? 0;
          return ProductExtra(name: name, price: price);
        }
        return ProductExtra(name: item.toString(), price: 0);
      }).toList();
    }
    return const [];
  }
}
