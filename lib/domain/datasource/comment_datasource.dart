import 'package:nike_store_flutter/domain/models/comment.dart';

abstract interface class ICommentDatasource {
  Future<List<CommentModel>> getAllByProductId(int productId);
}
