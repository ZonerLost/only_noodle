import '../models/category.dart';
import 'api_client.dart';
import 'endpoints/category_endpoints.dart';

class CategoryService {
  CategoryService(this._client);

  final ApiClient _client;

  Future<List<Category>> getCategories() async {
    final data = await _client.get(CategoryEndpoints.list, auth: false);
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(Category.fromJson).toList();
    }
    return [];
  }
}
