import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/data/repository/cart_repository_impl.dart';
import 'package:nike_store_flutter/domain/models/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartLoadRequested>((event, emit) => _load(emit));
    on<CartItemIncreaseRequested>(
      (event, emit) => _mutate(event.id, cartRepository.increaseItem, emit),
    );
    on<CartItemDecreaseRequested>(
      (event, emit) => _mutate(event.id, cartRepository.decreaseItem, emit),
    );
    on<CartItemRemoveRequested>(
      (event, emit) => _mutate(event.id, cartRepository.removeFromCart, emit),
    );
  }

  Future<void> _load(Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final result = await cartRepository.getCartItems();
      emit(CartLoaded(result.data ?? []));
    } on AppException catch (e) {
      emit(CartFailure(e.messageFa));
    } catch (_) {
      emit(const CartFailure('دریافت سبد خرید ناموفق بود.'));
    }
  }

  Future<void> _mutate(
    int id,
    Future Function(int) action,
    Emitter<CartState> emit,
  ) async {
    try {
      await action(id);
      await _load(emit);
    } on AppException catch (e) {
      emit(CartFailure(e.messageFa));
    } catch (_) {
      emit(const CartFailure('به‌روزرسانی سبد خرید ناموفق بود.'));
    }
  }
}
