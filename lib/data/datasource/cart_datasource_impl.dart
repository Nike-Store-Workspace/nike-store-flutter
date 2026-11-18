import 'package:dio/dio.dart';
import 'package:nike_store_flutter/common/api_endpoints.dart';
import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/data/common/http_response_validator.dart';
import 'package:nike_store_flutter/data/dto/add_to_cart_request_dto.dart';
import 'package:nike_store_flutter/domain/datasource/cart_datasource.dart';
import 'package:nike_store_flutter/domain/models/cart_item.dart';

class CartDatasourceImpl with HttpResponseValidator implements ICartDatasource {
  final Dio _httpClient;

  CartDatasourceImpl({required this._httpClient});

  @override
  Future<ApiResponse<void>> addToCart(AddToCartRequestDto request) async {
    final response = await _httpClient.post(
      addItemToCartApiEndpoint,
      data: request.toJson(),
    );
    validateHttpResponse(response);

    final result = ApiResponse.fromJson(response.data, (_) => null);

    if (!result.success) {
      throw ServerException(
        messageFa: result.messageFa,
        messageEn: result.messageEn,
      );
    }
    return result;
  }

  @override
  Future<ApiResponse<void>> decreaseItem(int cartItemId) async {
    final response = await _httpClient.patch(
      '$decreaseCartItemApiEndpoint/$cartItemId',
    );
    validateHttpResponse(response);

    final result = ApiResponse.fromJson(response.data, (_) => null);

    if (result.success) {
      return result;
    } else {
      throw ServerException(
        messageFa: result.messageFa,
        messageEn: result.messageEn,
      );
    }
  }

  @override
  Future<ApiResponse<List<CartItem>>> getCartItems() async {
    var response = await _httpClient.get(getCartItemsApiEndpoint);
    validateHttpResponse(response);

    final result = ApiResponse<List<CartItem>>.fromJson(
      response.data,
      (json) => json is List
          ? json.map((item) => CartItem.fromJson(item)).toList()
          : [],
    );

    if (result.success && result.data != null) {
      return result;
    } else {
      throw ServerException(
        messageEn: result.messageEn,
        messageFa: result.messageFa,
      );
    }
  }

  @override
  Future<ApiResponse<void>> increaseItem(int cartItemId) async {
    final response = await _httpClient.delete(
      '$increaseCartItemApiEndpoint/$cartItemId',
    );
    validateHttpResponse(response);

    final result = ApiResponse.fromJson(response.data, (_) => null);

    if (!result.success) {
      throw ServerException(
        messageFa: result.messageFa,
        messageEn: result.messageEn,
      );
    }

    return result;
  }

  @override
  Future<ApiResponse<void>> removeFromCart(int cartItemId) async {
    final response = await _httpClient.delete(
      '$removeCartItemApiEndpoint/$cartItemId',
    );
    validateHttpResponse(response);

    final result = ApiResponse.fromJson(response.data, (_) => null);

    if (!result.success) {
      throw ServerException(
        messageFa: result.messageFa,
        messageEn: result.messageEn,
      );
    }

    return result;
  }
}
