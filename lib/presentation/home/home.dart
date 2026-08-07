import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_store_flutter/data/repository/banner_repository_impl.dart';
import 'package:nike_store_flutter/data/repository/product_repository_impl.dart';
import 'package:nike_store_flutter/gen/assets.gen.dart';
import 'package:nike_store_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:nike_store_flutter/presentation/widgets/banner_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(productRepository, bannerRepository);
        homeBloc.add(HomeStartedEvent());
        return homeBloc;
      },
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeSuccess) {
              return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Column(
                        children: [
                          SizedBox(height: 20),

                          isDarkMode
                              ? Assets.img.nikeStorLogoDark.image(
                                  width: 130,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                              : Assets.img.nikeStorLogoLite.image(
                                  width: 130,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                          SizedBox(height: 30),
                          // Text(
                          //   'Nike Store',
                          //   style: Theme.of(context).textTheme.headlineSmall,
                          // ),
                        ],
                      );
                    case 1:
                      return const SizedBox(height: 20);
                    case 2:
                      return SizedBox(
                        height: 220,
                        child: BannerSlider(banners: state.banners),
                      );
                    case 3:
                      return const SizedBox(height: 20);
                    case 4:
                      return const Text('Product Section');
                    default:
                      return const SizedBox.shrink();
                  }
                },
              );
            } else if (state is HomeLoading) {
              return Center(
                child: Lottie.asset(
                  (isDarkMode)
                      ? 'assets/animations/nike_logo_animation_dark_theme.lottie'
                      : 'assets/animations/nike_logo_animation_lite_theme.lottie',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  repeat: true,
                ),
              );
            } else if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text(state.exception.message)),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(
                          context,
                        ).add(HomeRefreshEvent());
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              throw Exception('Invalid state: $state');
            }
          },
        ),
      ),
    );
  }
}
