import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/data/dto/add_to_cart_request_dto.dart';
import 'package:nike_store_flutter/domain/models/cart_item.dart';

abstract interface class ICartRepository {
  Future<ApiResponse<List<CartItem>>> getCartItems();
  Future<ApiResponse<void>> addToCart(AddToCartRequestDto request);
  Future<ApiResponse<void>> removeFromCart(int cartItemId);
  Future<ApiResponse<void>> increaseItem(int cartItemId);
  Future<ApiResponse<void>> decreaseItem(int cartItemId);
}
