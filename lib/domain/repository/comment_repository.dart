import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/domain/models/comment.dart';

abstract interface class ICommentRepository {
  Future<ApiResponse<List<CommentModel>>> getAllByProductId(int productId);
}
