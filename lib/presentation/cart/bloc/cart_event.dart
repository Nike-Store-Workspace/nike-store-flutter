part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class CartLoadRequested extends CartEvent {}

final class CartItemIncreaseRequested extends CartEvent {
  final int id;
  const CartItemIncreaseRequested(this.id);
  @override
  List<Object> get props => [id];
}

final class CartItemDecreaseRequested extends CartEvent {
  final int id;
  const CartItemDecreaseRequested(this.id);
  @override
  List<Object> get props => [id];
}

final class CartItemRemoveRequested extends CartEvent {
  final int id;
  const CartItemRemoveRequested(this.id);
  @override
  List<Object> get props => [id];
}
