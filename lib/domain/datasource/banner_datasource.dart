import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/domain/models/banner.dart';

abstract interface class IBannerDatasource {
  Future<ApiResponse<List<NikeStoreBanner>>> getAll(BannerLang lang);
}
