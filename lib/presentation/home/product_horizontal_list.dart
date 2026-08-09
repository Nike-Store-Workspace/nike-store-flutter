import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store_flutter/common/utils.dart';
import 'package:nike_store_flutter/domain/models/product.dart';
import 'package:nike_store_flutter/presentation/product_details/product_Details.dart';
import 'package:nike_store_flutter/presentation/widgets/image.dart';

class ProductHorizontalList extends StatelessWidget {
  final List<Product> productList;
  final String widgetTitle;
  final VoidCallback onMorePressed;
  const ProductHorizontalList({
    super.key,
    required this.productList,
    required this.widgetTitle,
    required this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widgetTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.apply(color: Colors.grey),
                ),
                TextButton(
                  onPressed: onMorePressed,
                  child: Text(
                    'بیشتر',
                    style: textTheme.titleSmall?.apply(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              physics: defaultScrollPhysics,
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return _ProductItem(
                  product: product,
                  isFirstItem: index == 0,
                  isLastItem: index == productList.length - 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  final bool _isFirstItem;
  final bool _isLastItem;
  const _ProductItem({
    super.key,
    required this.product,
    required this._isFirstItem,
    required this._isLastItem,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(
        right: (_isFirstItem) ? 16 : 4,
        left: (_isLastItem) ? 16 : 4,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetails(product: product),
            ),
          );
        },
        child: SizedBox(
          width: 200,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: ImageLoadingService(
                      imageUrl: product.images.first,
                      boxFit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),

                        if (product.previousPriceToman != null) ...[
                          Text(
                            product.previousPriceToman!.toPersianPrice,
                            style: textTheme.labelMedium?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],

                        SizedBox(height: 12),

                        Text(
                          product.priceToman.toPersianPrice,
                          style: textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(CupertinoIcons.heart, size: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
