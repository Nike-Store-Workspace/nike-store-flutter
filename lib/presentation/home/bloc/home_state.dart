part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final AppException exception;

  const HomeError({required this.exception});

  @override
  List<Object> get props => [exception];
}

final class HomeSuccess extends HomeState {
  final List<NikeStoreBanner> banners;
  final List<Product> latestProducts;
  final List<Product> cheapestProducts;
  final List<Product> mostExpensiveProducts;
  final List<Product> popularProducts;

  const HomeSuccess({
    required this.banners,
    required this.latestProducts,
    required this.popularProducts,
    required this.cheapestProducts,
    required this.mostExpensiveProducts,
  });

  @override
  List<Object> get props => [banners, latestProducts, popularProducts];
}
