import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;

  AppException({this.message = 'خطای نامشخص!'});
}

class ServerException extends AppException {
  ServerException({super.message});
}

class NetworkException extends AppException {
  NetworkException({super.message = 'اتصال اینترنت را بررسی کنید'});
}

extension ExceptionMapper on Object {
  AppException toAppException() {
    if (this is AppException) {
      return this as AppException;
    }

    if (this is DioException) {
      final dioError = this as DioException;
      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          return NetworkException();

        case DioExceptionType.badResponse:
          final responseData = dioError.response?.data;
          if (responseData is Map<String, dynamic> &&
              responseData['message'] != null) {
            return ServerException(message: responseData['message'].toString());
          }
          return ServerException(message: 'خطایی در پاسخ سرور رخ داد');

        default:
          return NetworkException(message: 'ارتباط با سرور برقرار نشد');
      }
    }

    return AppException(message: 'خطای غیرمنتظره‌ای رخ داده است');
  }
}
