import 'package:dio/dio.dart';
import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/data/common/http_response_validator.dart';
import 'package:nike_store_flutter/domain/datasource/product_datasource.dart';
import 'package:nike_store_flutter/domain/models/product.dart';

class RemoteProductDatasourceImpl
    with HttpResponseValidator
    implements IProductDatasource {
  const RemoteProductDatasourceImpl({required this.httpClient});
  final Dio httpClient;

  @override
  Future<List<Product>> getAll(String sort) async {
    final response = await httpClient.get('products?sort=$sort');
    validateHttpResponse(response);

    final products = <Product>[];
    final data = response.data['data'] as List;

    data.forEach((element) {
      products.add(Product.fromJson(element));
    });
    return products;
  }

  @override
  Future<List<Product>> search(String searchTerm) async {
    final response = await httpClient.get('pro ducts?sort=$searchTerm');
    validateHttpResponse(response);

    final products = <Product>[];
    (response.data as List).forEach((element) {
      products.add(Product.fromJson(element));
    });
    return products;
  }
}
