import 'package:dio/dio.dart';

final baseDomain = 'http://192.168.70.186:8090';
// final baseDomain = 'http://10.19.25.105:8090';
final baseUrl = 'http://192.168.70.186:8090/api/v1/';
// final baseUrl = 'http://10.19.25.105:8090/api/v1/';

final httpClient = Dio(BaseOptions(baseUrl: baseUrl));
