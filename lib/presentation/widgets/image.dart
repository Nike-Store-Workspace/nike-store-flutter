import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nike_store_flutter/common/http_client.dart';

class ImageLoadingService extends StatelessWidget {
  final String imageUrl;
  const ImageLoadingService({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: baseDomain + imageUrl);
  }
}
