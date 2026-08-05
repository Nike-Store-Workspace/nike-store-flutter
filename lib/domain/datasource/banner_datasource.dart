import 'package:nike_store_flutter/domain/models/banner.dart';

abstract interface class IBannerDatasource {
  Future<List<NikeStoreBanner>> getAll(BannerLang lang);
}
