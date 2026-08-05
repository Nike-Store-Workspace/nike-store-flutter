import 'package:nike_store_flutter/domain/models/product.dart';

abstract interface class IProductRepository {
  Future<List<Product>> getAll(String sort);
  Future<List<Product>> search(String searchTerm);
}
