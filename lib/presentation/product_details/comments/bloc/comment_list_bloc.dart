import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/domain/models/comment.dart';
import 'package:nike_store_flutter/domain/repository/comment_repository.dart';

part 'comment_list_event.dart';
part 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final ICommentRepository commentRepository;
  CommentListBloc({required this.commentRepository})
    : super(CommentListInitial()) {
    on<CommentListEvent>((event, emit) async {
      if (event is CommentListStarted) {
        emit(CommentListLoading());
        await Future.delayed(const Duration(milliseconds: 1500)).then((
          value,
        ) async {
          try {
            final comments = await commentRepository.getAllByProductId(
              event.productId,
            );
            emit(CommentListSuccess(comments: comments));
          } on AppException catch (e) {
            emit(CommentListError(exception: e));
          } catch (e) {
            emit(CommentListError(exception: e.toAppException()));
          }
        });
      }
    });
  }
}
