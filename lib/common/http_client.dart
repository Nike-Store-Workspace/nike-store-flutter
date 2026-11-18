import 'package:dio/dio.dart';
import 'package:nike_store_flutter/data/repository/auth_repository_impl.dart';
import 'package:nike_store_flutter/presentation/settings/app_preferences.dart';

// final baseDomain = 'http://192.168.70.186:8090';
final baseDomain = 'http://10.0.2.2:8090';
// final baseUrl = 'http://192.168.70.186:8090/api/v1/';
final baseUrl = 'http://10.0.2.2:8090/api/v1/';

final httpClient = Dio(BaseOptions(baseUrl: baseUrl))
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final authInfo =
            AuthRepositoryImpl.authChangeNotifier.value?.token ?? "";

        options.queryParameters.putIfAbsent(
          'lang',
          () => AppPreferences.locale.value.languageCode,
        );
        if (authInfo.isNotEmpty) {
          options.headers['Authorization'] =
              'Bearer ${AuthRepositoryImpl.authChangeNotifier.value?.token ?? ""}';
        }
        handler.next(options);
      },
    ),
  );
