import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/data/dto/add_to_cart_request_dto.dart';
import 'package:nike_store_flutter/domain/repository/cart_repository.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ICartRepository repo;

  ProductDetailsBloc({required this.repo}) : super(ProductDetailsInitial()) {
    on<ProductDetailsEvent>((event, emit) async {
      if (event is CartAddButtonPressed) {
        final ApiResponse response = await repo.addToCart(
          AddToCartRequestDto(
            productId: event.productId,
            variantId: event.variantId,
          ),
        );
        if (response.success) {
          emit(
            ProductAddedToCartSuccess(
              messageFa: response.messageFa,
              messageEn: response.messageEn,
            ),
          );
        } else {
          emit(
            ProductAddToCartError(
              exception: AppException(
                messageFa: response.messageFa,
                messageEn: response.messageEn,
              ),
            ),
          );
        }
      }
    });
  }
}
