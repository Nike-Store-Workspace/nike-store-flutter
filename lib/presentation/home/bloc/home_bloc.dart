import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/domain/models/banner.dart';
import 'package:nike_store_flutter/domain/models/product.dart';
import 'package:nike_store_flutter/domain/repository/banner_repository.dart';
import 'package:nike_store_flutter/domain/repository/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IProductRepository productRepository;
  final IBannerRepository bannerRepository;

  HomeBloc(this.productRepository, this.bannerRepository)
    : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStartedEvent || event is HomeRefreshEvent) {
        try {
          emit(HomeLoading());
          await Future.delayed(const Duration(seconds: 5));
          final banners = await bannerRepository.getAll(BannerLang.fa);
          final latestProducts = await productRepository.getAll(
            ProductSort.newest,
          );
          final popularProducts = await productRepository.getAll(
            ProductSort.popular,
          );

          emit(
            HomeSuccess(
              banners: banners,
              latestProducts: latestProducts,
              popularProducts: popularProducts,
            ),
          );
        } catch (e) {
          emit(
            HomeError(
              exception: e is AppException
                  ? e
                  : AppException(message: e.toString()),
            ),
          );
        }
      }
    });
  }
}
