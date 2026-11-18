part of 'product_details_bloc.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

class ProductAddToCartLoading extends ProductDetailsState {}

class ProductAddToCartError extends ProductDetailsState {
  final AppException exception;

  const ProductAddToCartError({required this.exception});

  @override
  List<Object> get props => [exception];
}

class ProductAddedToCartSuccess extends ProductDetailsState {
  final String messageFa;
  final String messageEn;

  const ProductAddedToCartSuccess({
    required this.messageFa,
    required this.messageEn,
  });
}
