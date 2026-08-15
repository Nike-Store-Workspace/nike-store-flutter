import 'package:dio/dio.dart';
import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/data/common/api_response.dart';

mixin HttpResponseValidator {
  void validateHttpResponse(Response response) {
    final apiResponse = ApiResponse.fromJson(response.data, (json) {});
    if (response.statusCode! < 200 || response.statusCode! >= 300) {
      throw AppException(
        messageEn: apiResponse.messageEn,
        messageFa: apiResponse.messageFa,
      );
    }
  }
}
