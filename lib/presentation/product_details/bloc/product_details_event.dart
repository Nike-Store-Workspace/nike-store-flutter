part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailsEventInitial extends ProductDetailsEvent {}

class ProductAddToCartLoadingEvent extends ProductDetailsEvent {}

class CartAddButtonPressed extends ProductDetailsEvent {
  final int productId;
  final int variantId;

  const CartAddButtonPressed({
    required this.productId,
    required this.variantId,
  });
}
