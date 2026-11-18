import 'package:nike_store_flutter/common/http_client.dart';
import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/data/datasource/cart_datasource_impl.dart';
import 'package:nike_store_flutter/data/dto/add_to_cart_request_dto.dart';
import 'package:nike_store_flutter/domain/datasource/cart_datasource.dart';
import 'package:nike_store_flutter/domain/models/cart_item.dart';
import 'package:nike_store_flutter/domain/repository/cart_repository.dart';

final ICartRepository cartRepository = CartRepositoryImpl(
  datasource: CartDatasourceImpl(httpClient: httpClient),
);

class CartRepositoryImpl implements ICartRepository {
  final ICartDatasource datasource;

  CartRepositoryImpl({required this.datasource});

  @override
  Future<ApiResponse<void>> addToCart(AddToCartRequestDto request) {
    return datasource.addToCart(request);
  }

  @override
  Future<ApiResponse<void>> decreaseItem(int cartItemId) {
    return datasource.decreaseItem(cartItemId);
  }

  @override
  Future<ApiResponse<List<CartItem>>> getCartItems() {
    return datasource.getCartItems();
  }

  @override
  Future<ApiResponse<void>> increaseItem(int cartItemId) {
    return datasource.increaseItem(cartItemId);
  }

  @override
  Future<ApiResponse<void>> removeFromCart(int cartItemId) {
    return datasource.removeFromCart(cartItemId);
  }
}
