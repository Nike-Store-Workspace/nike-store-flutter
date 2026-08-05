import 'package:dio/dio.dart';

final httpClient = Dio(
  BaseOptions(baseUrl: 'http://192.168.70.186:8090/api/v1/'),
);
