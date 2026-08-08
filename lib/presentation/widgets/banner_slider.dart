import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nike_store_flutter/common/utils.dart';
import 'package:nike_store_flutter/domain/models/banner.dart';
import 'package:nike_store_flutter/presentation/widgets/image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final List<NikeStoreBanner> banners;
  const BannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Stack(
      children: [
        PageView.builder(
          physics: defaultScrollPhysics,
          controller: pageController,
          itemCount: banners.length,
          padEnds: true,
          itemBuilder: (context, index) {
            final banner = banners[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: ImageLoadingService(
                  imageUrl: banner.address,
                  boxFit: BoxFit.cover,
                ),
              ),
            );
          },
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SmoothPageIndicator(
              controller: pageController,
              count: banners.length,
              axisDirection: Axis.horizontal,
              effect: WormEffect(
                dotWidth: 20,
                dotHeight: 3,
                spacing: 3,
                activeDotColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
