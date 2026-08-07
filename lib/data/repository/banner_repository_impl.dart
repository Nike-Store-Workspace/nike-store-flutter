import 'package:nike_store_flutter/common/http_client.dart';
import 'package:nike_store_flutter/data/datasource/banner_datasource_impl.dart';
import 'package:nike_store_flutter/domain/datasource/banner_datasource.dart';
import 'package:nike_store_flutter/domain/models/banner.dart';
import 'package:nike_store_flutter/domain/repository/banner_repository.dart';

final bannerRepository = BannerRepositoryImpl(BannerDatasourceImpl(httpClient));

class BannerRepositoryImpl implements IBannerRepository {
  final IBannerDatasource _datasource;

  BannerRepositoryImpl(this._datasource);

  @override
  Future<List<NikeStoreBanner>> getAll(BannerLang lang) async {
    return _datasource.getAll(lang);
  }
}
