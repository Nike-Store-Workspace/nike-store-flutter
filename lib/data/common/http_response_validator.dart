import 'package:dio/dio.dart';
import 'package:nike_store_flutter/common/exception.dart';

mixin HttpResponseValidator {
  void validateHttpResponse(Response response) {
    if (response.statusCode! < 200 || response.statusCode! >= 300) {
      throw AppException(message: 'خطای نامشخص');
    }
  }
}
