import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store_flutter/common/utils.dart';
import 'package:nike_store_flutter/domain/models/product.dart';
import 'package:nike_store_flutter/presentation/product_details/comments/comment_list.dart';
import 'package:nike_store_flutter/presentation/widgets/image.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              if (product.previousPriceToman != null) ...[
                                Text(
                                  product.previousPriceToman?.toPersianPrice ??
                                      '',
                                  style: textTheme.titleSmall!.apply(
                                    decoration: TextDecoration.lineThrough,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 32,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('نظرات کاربران', style: textTheme.labelLarge),
                          TextButton(
                            onPressed: () {},

                            child: Text(
                              'ثبت نظر',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(100)),
            ),
            onPressed: () {},
            label: Text('افزودن به سبد خرید'),
          ),
        ),
      ),
    );
  }
}
