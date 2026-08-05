import 'package:nike_store_flutter/domain/models/banner.dart';

abstract interface class IBannerRepository {
  Future<List<NikeStoreBanner>> getAll(BannerLang lang);
}
