import 'package:dio/dio.dart';
import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/data/common/http_response_validator.dart';
import 'package:nike_store_flutter/domain/datasource/product_datasource.dart';
import 'package:nike_store_flutter/domain/models/product.dart';

class RemoteProductDatasourceImpl
    with HttpResponseValidator
    implements IProductDatasource {
  const RemoteProductDatasourceImpl({required this.httpClient});
  final Dio httpClient;

  @override
  Future<ApiResponse<List<Product>>> getAll(String sort) async {
    final response = await httpClient.get('products?sort=$sort');
    validateHttpResponse(response);

    final products = <Product>[];
    final res = ApiResponse.fromJson(response.data, (json) {
      for (var element in (json as List<dynamic>)) {
        products.add(Product.fromJson(element));
      }
      return products;
    });
    return res;
  }

  @override
  Future<ApiResponse<List<Product>>> search(String searchTerm) async {
    final response = await httpClient.get('pro ducts?sort=$searchTerm');
    validateHttpResponse(response);

    final products = <Product>[];
    final res = ApiResponse.fromJson(response.data, (json) {
      for (var element in (json as List<dynamic>)) {
        products.add(Product.fromJson(element));
      }
      return products;
    });
    return res;
  }
}
