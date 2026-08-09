import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/common/http_client.dart';
import 'package:nike_store_flutter/data/datasource/comment_datasource_impl.dart';
import 'package:nike_store_flutter/domain/datasource/comment_datasource.dart';
import 'package:nike_store_flutter/domain/models/comment.dart';
import 'package:nike_store_flutter/domain/repository/comment_repository.dart';

final commentRepository = CommentRepositoryImpl(
  datasource: RemoteCommentDatasourceImpl(httpClient: httpClient),
);

class CommentRepositoryImpl implements ICommentRepository {
  final ICommentDatasource datasource;

  CommentRepositoryImpl({required this.datasource});

  @override
  Future<List<CommentModel>> getAllByProductId(int productId) async {
    try {
      return await datasource.getAllByProductId(productId);
    } catch (e) {
      throw e.toAppException();
    }
  }
}
