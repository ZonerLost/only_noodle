import '../models/category.dart';
import '../models/product.dart';
import '../models/restaurant.dart';
import 'api_client.dart';
import 'endpoints/restaurant_endpoints.dart';

class RestaurantMenu {
  final List<Category> categories;
  final List<Product> products;

  const RestaurantMenu({
    required this.categories,
    required this.products,
  });
}

class RestaurantService {
  RestaurantService(this._client);

  final ApiClient _client;

  Future<List<Restaurant>> getRestaurants({
    String? search,
    String? cuisineType,
    bool? isOpen,
    String? sortBy,
    String? sortOrder,
  }) async {
    final data = await _client.get(
      RestaurantEndpoints.list,
      auth: false,
      query: {
        if (search != null && search.isNotEmpty) 'search': search,
        if (cuisineType != null && cuisineType.isNotEmpty)
          'cuisineType': cuisineType,
        if (isOpen != null) 'isOpen': isOpen.toString(),
        if (sortBy != null && sortBy.isNotEmpty) 'sortBy': sortBy,
        if (sortOrder != null && sortOrder.isNotEmpty) 'sortOrder': sortOrder,
      },
    );
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(Restaurant.fromJson).toList();
    }
    return [];
  }

  Future<List<Restaurant>> getNearbyRestaurants({
    String? address,
    String? lat,
    String? lng,
  }) async {
    final data = await _client.get(
      RestaurantEndpoints.nearby,
      auth: false,
      query: {
        if (address != null) 'address': address,
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
      },
    );
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(Restaurant.fromJson).toList();
    }
    return [];
  }

  Future<List<Restaurant>> searchRestaurants(String query) async {
    final data = await _client.get(
      RestaurantEndpoints.search,
      auth: false,
      query: {'query': query},
    );
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(Restaurant.fromJson).toList();
    }
    return [];
  }

  Future<Restaurant> getRestaurant(String id) async {
    final data = await _client.get(RestaurantEndpoints.details(id), auth: false);
    if (data is Map<String, dynamic>) {
      return Restaurant.fromJson(data);
    }
    throw Exception('Invalid restaurant response');
  }

  Future<RestaurantMenu> getMenu(String id) async {
    final data = await _client.get(RestaurantEndpoints.menu(id), auth: false);
    if (data is Map<String, dynamic>) {
      if (data['menu'] is List) {
        final menu = data['menu'] as List;
        final categories = <Category>[];
        final products = <Product>[];
        for (final entry in menu) {
          if (entry is! Map<String, dynamic>) continue;
          final categoryJson = entry['category'] as Map<String, dynamic>?;
          final items = entry['items'] as List? ?? [];
          if (categoryJson != null) {
            categories.add(Category.fromJson(categoryJson));
            final categoryId =
                (categoryJson['id'] ?? categoryJson['_id'] ?? '').toString();
            for (final item in items) {
              if (item is! Map<String, dynamic>) continue;
              final itemWithCategory = <String, dynamic>{
                ...item,
                'categoryId': categoryId,
              };
              products.add(Product.fromJson(itemWithCategory));
            }
          } else {
            for (final item in items) {
              if (item is! Map<String, dynamic>) continue;
              products.add(Product.fromJson(item));
            }
          }
        }
        return RestaurantMenu(categories: categories, products: products);
      }
      final categories = (data['categories'] as List? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(Category.fromJson)
          .toList();
      final products = (data['products'] as List? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(Product.fromJson)
          .toList();
      return RestaurantMenu(categories: categories, products: products);
    }
    return const RestaurantMenu(categories: [], products: []);
  }

  Future<List<Map<String, dynamic>>> getReviews(String id) async {
    final data = await _client.get(RestaurantEndpoints.reviews(id), auth: false);
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().toList();
    }
    return [];
  }

  Future<void> createReview({
    required String id,
    required double rating,
    String? comment,
  }) async {
    await _client.post(
      RestaurantEndpoints.reviews(id),
      body: {
        'rating': rating,
        if (comment != null) 'comment': comment,
      },
    );
  }
}
