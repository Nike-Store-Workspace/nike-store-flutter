import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/domain/models/banner.dart';
import 'package:nike_store_flutter/domain/models/product.dart';
import 'package:nike_store_flutter/domain/repository/banner_repository.dart';
import 'package:nike_store_flutter/domain/repository/product_repository.dart';
import 'package:nike_store_flutter/presentation/settings/app_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IProductRepository productRepository;
  final IBannerRepository bannerRepository;

  HomeBloc(this.productRepository, this.bannerRepository)
    : super(HomeLoading()) {
    AppPreferences.locale.addListener(_onLocaleChanged);
    on<HomeEvent>((event, emit) async {
      if (event is HomeStartedEvent || event is HomeRefreshEvent) {
        try {
          emit(HomeLoading());
          await Future.delayed(const Duration(seconds: 0));
          final lang = AppPreferences.locale.value.languageCode == 'en'
              ? BannerLang.en
              : BannerLang.fa;
          final banners = await bannerRepository.getAll(lang);
          final latestProducts = await productRepository.getAll(
            ProductSort.newest,
          );
          final popularProducts = await productRepository.getAll(
            ProductSort.popular,
          );
          final cheapestProducts = await productRepository.getAll(
            ProductSort.priceAsc,
          );
          final mostExpensiveProducts = await productRepository.getAll(
            ProductSort.priceDesc,
          );

          emit(
            HomeSuccess(
              banners: banners.data ?? [],
              latestProducts: latestProducts.data ?? [],
              popularProducts: popularProducts.data ?? [],
              cheapestProducts: cheapestProducts.data ?? [],
              mostExpensiveProducts: mostExpensiveProducts.data ?? [],
            ),
          );
        } catch (e) {
          emit(
            HomeError(
              exception: e is AppException
                  ? e
                  : AppException(
                      messageEn: e.toString(),
                      messageFa: e.toString(),
                    ),
            ),
          );
        }
      }
    });
  }

  void _onLocaleChanged() => add(HomeRefreshEvent());

  @override
  Future<void> close() {
    AppPreferences.locale.removeListener(_onLocaleChanged);
    return super.close();
  }
}
