import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store_flutter/common/utils.dart';
import 'package:nike_store_flutter/data/repository/comment_repository_impl.dart';
import 'package:nike_store_flutter/domain/models/comment.dart';
import 'package:nike_store_flutter/presentation/home/home.dart';
import 'package:nike_store_flutter/presentation/product_details/comments/bloc/comment_list_bloc.dart';

class CommentList extends StatelessWidget {
  final int productId;

  const CommentList({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) {
        final commentListBloc = CommentListBloc(
          commentRepository: commentRepository,
        );
        commentListBloc.add(CommentListStarted(productId: productId));

        return commentListBloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListSuccess) {
            return state.comments.isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100.0),
                      child: Center(
                        child: Text(
                          'نظری ثبت نشده! \n تو اولین نفر باش🎉',
                          textAlign: TextAlign.center,
                          style: textTheme.labelLarge,
                        ),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return CommentItem(
                        commentModel: state.comments[index],
                        isFirstItem: index == 0,
                        isLastItem: index + 1 == state.comments.length,
                      );
                    }, childCount: state.comments.length),
                  );
          } else if (state is CommentListLoading ||
              state is CommentListInitial) {
            // ✅ wrap کردن با SliverToBoxAdapter
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Loading(isDarkMode: isDarkMode),
              ),
            );
          } else if (state is CommentListError) {
            return SliverToBoxAdapter(
              child: Center(
                child: Column(
                  children: [
                    Text(state.exception.message),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<CommentListBloc>(
                          context,
                        ).add(CommentListStarted(productId: productId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            throw Exception('Unknown state in Comment');
          }
        },
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentModel commentModel;
  final bool isFirstItem;
  final bool isLastItem;
  const CommentItem({
    super.key,
    required this.commentModel,
    required this.isFirstItem,
    required this.isLastItem,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final double bottomPadding = (isLastItem == true ? 150 : 0);
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding),
      child: Container(
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: const Color.fromARGB(255, 230, 230, 230),
            width: 0.2,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isFirstItem ? 10 : 0),
            topRight: Radius.circular(isFirstItem ? 10 : 0),
            bottomLeft: Radius.circular(isLastItem ? 10 : 0),
            bottomRight: Radius.circular(isLastItem ? 10 : 0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(commentModel.titleFa!, style: textTheme.titleSmall),
                      SizedBox(height: 3),
                      Text(
                        'توسط ${commentModel.userName!}',
                        style: textTheme.labelMedium,
                      ),
                    ],
                  ),

                  Text(
                    commentModel.createdAt!.toPersianDate,
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
              SizedBox(height: 16),

              Text(commentModel.body!, style: textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
