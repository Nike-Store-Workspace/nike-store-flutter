import 'package:dio/dio.dart';
import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/data/common/http_response_validator.dart';
import 'package:nike_store_flutter/domain/datasource/comment_datasource.dart';
import 'package:nike_store_flutter/domain/models/comment.dart';
import 'package:nike_store_flutter/presentation/settings/app_preferences.dart';

class RemoteCommentDatasourceImpl
    with HttpResponseValidator
    implements ICommentDatasource {
  final Dio httpClient;

  RemoteCommentDatasourceImpl({required this.httpClient});

  @override
  Future<ApiResponse<List<CommentModel>>> getAllByProductId(
    int productId,
  ) async {
    final response = await httpClient.get('comments/$productId', queryParameters: {'lang': AppPreferences.locale.value.languageCode});
    validateHttpResponse(response);

    final result = ApiResponse<List<CommentModel>>.fromJson(
      response.data,
      (json) => json is List
          ? json
                .map(
                  (item) => CommentModel.fromJson(item as Map<String, dynamic>),
                )
                .toList()
          : [],
    );

    if (result.success && result.data != null) {
      return result;
    } else {
      throw ServerException(
        messageFa: result.messageFa,
        messageEn: result.messageEn,
      );
    }
  }
}
