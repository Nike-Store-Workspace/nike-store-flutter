import 'package:dio/dio.dart';
import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/data/common/http_response_validator.dart';
import 'package:nike_store_flutter/domain/datasource/banner_datasource.dart';
import 'package:nike_store_flutter/domain/models/banner.dart';

class BannerDatasourceImpl
    with HttpResponseValidator
    implements IBannerDatasource {
  final Dio httpClient;

  BannerDatasourceImpl(this.httpClient);

  @override
  Future<ApiResponse<List<NikeStoreBanner>>> getAll(BannerLang lang) async {
    final response = await httpClient.get(
      '/banners',
      queryParameters: {'lang': lang.name},
    );
    validateHttpResponse(response);
    if (response.data['data'] == null) {
      throw Exception('Invalid response data: ${response.data}');
    }
    final banners = <NikeStoreBanner>[];

    final res = ApiResponse.fromJson(response.data, (json) {
      for (var element in (json as List<dynamic>)) {
        banners.add(NikeStoreBanner.fromJson(element));
      }

      return banners;
    });
    return res;
  }
}
