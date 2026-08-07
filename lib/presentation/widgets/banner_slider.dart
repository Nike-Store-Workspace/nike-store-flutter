import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          physics: BouncingScrollPhysics(),
          controller: pageController,
          itemCount: banners.length,
          padEnds: true,
          itemBuilder: (context, index) {
            final banner = banners[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: ImageLoadingService(imageUrl: banner.address),
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
              count: 9,
              axisDirection: Axis.horizontal,
              effect: WormEffect(dotWidth: 10, dotHeight: 5),
            ),
          ),
        ),
      ],
    );
  }
}
