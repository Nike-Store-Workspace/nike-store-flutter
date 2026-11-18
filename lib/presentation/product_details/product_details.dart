import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store_flutter/common/utils.dart';
import 'package:nike_store_flutter/data/repository/cart_repository_impl.dart';
import 'package:nike_store_flutter/domain/models/product.dart';
import 'package:nike_store_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:nike_store_flutter/presentation/product_details/bloc/product_details_bloc.dart';
import 'package:nike_store_flutter/presentation/product_details/comments/comment_list.dart';
import 'package:nike_store_flutter/presentation/widgets/image.dart';
import 'package:nike_store_flutter/presentation/settings/app_preferences.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int? selectedVariantId;
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final en = AppPreferences.locale.value.languageCode == 'en';
    final textTheme = Theme.of(context).textTheme;
    return Directionality(
      textDirection: en ? TextDirection.ltr : TextDirection.rtl,
      child: BlocProvider<ProductDetailsBloc>(
        create: (context) =>
            ProductDetailsBloc(repo: cartRepository)
              ..add(ProductDetailsEventInitial()),
        child: BlocListener<ProductDetailsBloc, ProductDetailsState>(
          listener: (context, state) {
            if (state is ProductAddedToCartSuccess) {
              ScaffoldMessenger.of(
                context,
                ).showSnackBar(SnackBar(content: Text(en ? state.messageEn : state.messageFa)));
            } else if (state is ProductAddToCartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(en ? state.exception.messageEn : state.exception.messageFa)),
              );
            }
          },
          child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, state) {
              return Scaffold(
                body: CustomScrollView(
                  physics: defaultScrollPhysics,
                  slivers: [
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.width * 0.7,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: ImageLoadingService(
                              imageUrl: product.images.first,
                              boxFit: BoxFit.contain, // یا BoxFit.scaleDown
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(CupertinoIcons.heart),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Text(
                                      product.title,
                                      style: textTheme.titleMedium,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Column(
                                    children: [
                                      if (product.previousPriceToman !=
                                          null) ...[
                                        Text(
                                          product
                                                  .previousPriceToman
                                                  ?.toPersianPrice ??
                                              '',
                                          style: textTheme.titleSmall!.apply(
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                      Text(
                                        product.priceToman.toPersianPrice,
                                        style: textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 16.0,
                              ),
                              child: Text(product.description),
                            ),
                            if (product.variants.isNotEmpty) ...[
                              Text(en ? 'Choose size and color' : 'انتخاب رنگ و سایز', style: textTheme.titleSmall),
                              Wrap(spacing: 8, children: product.variants.where((v) => v.stock > 0).map((v) => ChoiceChip(label: Text('${v.color} · ${v.size}'), selected: selectedVariantId == v.id || (selectedVariantId == null && v == product.variants.firstWhere((x) => x.stock > 0, orElse: () => v)), onSelected: (_) => setState(() => selectedVariantId = v.id))).toList()),
                            ],
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: 32,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    en ? 'Customer reviews' : 'نظرات کاربران',
                                    style: textTheme.labelLarge,
                                  ),
                                  TextButton(
                                    onPressed: () {},

                                    child: Text(
                                      en ? 'Write a review' : 'ثبت نظر',
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CommentList(productId: product.id),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      final bloc = context.read<ProductDetailsBloc>();
                      bloc.add(ProductAddToCartLoadingEvent());

                      final variant = product.variants.where((v) => v.stock > 0).where((v) => v.id == selectedVariantId).firstOrNull ?? product.variants.where((v) => v.stock > 0).firstOrNull;
                      if (variant != null) {
                        bloc.add(
                          CartAddButtonPressed(
                            productId: product.id,
                            variantId: variant.id,
                          ),
                        );
                      }
                    },
                    label: (state is ProductAddToCartLoading)
                        ? CircularProgressIndicator(strokeWidth: 2)
                        : Text(en ? 'Add to cart' : 'افزودن به سبد خرید'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
