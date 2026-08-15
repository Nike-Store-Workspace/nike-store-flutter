import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/domain/models/product.dart';

abstract interface class IProductRepository {
  Future<ApiResponse<List<Product>>> getAll(String sort);
  Future<ApiResponse<List<Product>>> search(String searchTerm);
}
