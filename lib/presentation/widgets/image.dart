import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nike_store_flutter/common/http_client.dart';

class ImageLoadingService extends StatelessWidget {
  final String imageUrl;
  final BoxFit _boxFit;
  final double? width;
  final double? height;

  const ImageLoadingService({
    super.key,
    required this.imageUrl,
    required this._boxFit,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: baseDomain + imageUrl,
      fit: _boxFit,
      width: width,
      height: height,
    );
  }
}
