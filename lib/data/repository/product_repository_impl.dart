import 'package:nike_store_flutter/common/http_client.dart';
import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/data/datasource/product_datasource_impl.dart';
import 'package:nike_store_flutter/domain/datasource/product_datasource.dart';
import 'package:nike_store_flutter/domain/models/product.dart';
import 'package:nike_store_flutter/domain/repository/product_repository.dart';

final productRepository = ProductRepositoryImpl(
  datasource: RemoteProductDatasourceImpl(httpClient: httpClient),
);

class ProductRepositoryImpl implements IProductRepository {
  final IProductDatasource _datasource;

  const ProductRepositoryImpl({required this._datasource});

  @override
  Future<ApiResponse<List<Product>>> getAll(String sort) {
    return _datasource.getAll(sort);
  }

  @override
  Future<ApiResponse<List<Product>>> search(String searchTerm) {
    return _datasource.search(searchTerm);
  }
}
