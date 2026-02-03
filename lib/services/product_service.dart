import '../models/product.dart';
import 'api_client.dart';
import 'endpoints/product_endpoints.dart';

class ProductService {
  ProductService(this._client);

  final ApiClient _client;

  Future<List<Product>> getProducts() async {
    final data = await _client.get(ProductEndpoints.list, auth: false);
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(Product.fromJson).toList();
    }
    return [];
  }

  Future<List<Product>> getFeaturedProducts() async {
    final data = await _client.get(ProductEndpoints.featured, auth: false);
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(Product.fromJson).toList();
    }
    return [];
  }

  Future<List<Product>> searchProducts(String query) async {
    final data = await _client.get(
      ProductEndpoints.search,
      auth: false,
      query: {'q': query},
    );
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(Product.fromJson).toList();
    }
    return [];
  }

  Future<Product> getProduct(String id) async {
    final data = await _client.get(ProductEndpoints.details(id), auth: false);
    if (data is Map<String, dynamic>) {
      return Product.fromJson(data);
    }
    throw Exception('Invalid product response');
  }
}
