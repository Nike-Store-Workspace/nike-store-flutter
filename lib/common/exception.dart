import 'package:dio/dio.dart';

class AppException implements Exception {
  final String messageEn;
  final String messageFa;

  AppException({required this.messageFa, required this.messageEn});
}

class ServerException extends AppException {
  ServerException({required super.messageFa, required super.messageEn});
}

class NetworkException extends AppException {
  NetworkException({
    super.messageFa = 'اتصال اینترنت را بررسی کنید',
    super.messageEn = 'Please check your internet connection',
  });
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
            return ServerException(
              messageFa: responseData['message_fa'].toString(),
              messageEn: responseData['message_en'].toString(),
            );
          }
          return ServerException(
            messageFa: responseData['message_fa'].toString(),
            messageEn: responseData['message_en'].toString(),
          );

        default:
          return NetworkException(
            messageFa: 'ارتباط با سرور برقرار نشد',
            messageEn: 'Network connection error',
          );
      }
    }

    return AppException(
      messageFa: 'خطای غیرمنتظره‌ای رخ داده است',
      messageEn: 'Unknown exception occurred',
    );
  }
}
